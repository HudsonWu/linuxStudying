Docker多阶段镜像构建

> FROM muninn/glide:alpine AS build-env
> ADD . /go/src/my-proj
> WORKDIR /go/src/my-proj
> RUN go get -v
> RUN go build -o /go/src/my-proj/my-server
> 
> FROM alpine
> RUN apk add -U tzdata
> RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
> COPY --from=build-env /go/src/my-proj/my-server /my-server
> EXPOSE 80
> CMD ["my-server"]
