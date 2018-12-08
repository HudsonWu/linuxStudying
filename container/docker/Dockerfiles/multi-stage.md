## Docker多阶段镜像构建

> + 在多个build阶段之间建立内在连接, 让后一个阶段构建可以使用前一个阶段构建的产物, 形成一条构建阶段的chain
> + 最终仅产生一个image, 避免产生多个临时images或临容器对象


```
FROM muninn/glide:alpine AS build-env
ADD . /go/src/my-proj
WORKDIR /go/src/my-proj
RUN go get -v
RUN go build -o /go/src/my-proj/my-server

FROM alpine
RUN apk add -U tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY --from=build-env /go/src/my-proj/my-server /my-server
EXPOSE 80
CMD ["my-server"]
```
