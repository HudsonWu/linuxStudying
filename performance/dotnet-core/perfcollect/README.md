# Collecting .NET Core Linux Container CPU Traces

## Building Container Images

```Dockerfile
FROM microsoft/dotnet:2.2-sdk AS builder
WORKDIR /build

COPY *.csproj .
# Restore with `-r linux-x64` to download the runtime package containing crossgen.
RUN dotnet restore -r linux-x64
RUN cp `find ~/.nuget/packages -name crossgen` .
# Restore without `-r` option
RUN dotnet restore

COPY . .
RUN dotnet publish -c release -o out

FROM microsoft/dotnet:2.2-aspnetcore-runtime as application

# COMPlus_PerfMapEnabled is set in order to resolve symbols for .NET code.
ENV COMPlus_PerfMapEnabled=1

WORKDIR /app
COPY --from=builder /build/out /build/crossgen ./

ENTRYPOINT ["dotnet", "webapi.dll"]

FROM application as sidecar
RUN apt-get update \
    && apt-get install -y \
       binutils \
       curl \
       htop \
       procps \
       liblttng-ust-dev \
       linux-tools \
       lttng-tools \
       zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tools

RUN curl -OL http://aka.ms/perfcollect \
    && chmod +x perfcollect

# perfcollect expects to find crossgen along side libcoreclr.so
RUN cp /app/crossgen $(dirname `find /usr/share/dotnet/ -name libcoreclr.so`)

ENTRYPOINT ["/bin/bash"]
```

```
# build the application image
docker build . --target application -f Dockerfile -t application

# build the sidecar image
docker build . --target sidecar -f Dockerfile -t sidecar
```

## Running Docker Containers

```
# run the application
docker run -p 80:80 -v shared-tmp:/tmp --name application application

# run the sidecar
docker run -it --pid=container:application --net=container:application -v shared-tmp:/tmp --cap-add ALL --privileged --name sidecar sidecar
```

## Collection CPU Performance Traces

```
# capture performance data for the dotnet process
./perfcollect collect sample -nolttng -pid 1

# generate some requests to the webapi service
ab -n 200 -c 10 http://10.1.0.4/api/values

# view the report
./perfcollect view sample.trace.zip
# list contents in the zip file
unzip -l sample.trace.zip
```
