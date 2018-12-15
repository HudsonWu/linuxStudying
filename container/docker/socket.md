# /var/run/docker.sock, Unix套接字

`docker.sock` is the UNIX socket that Docker daemon is listening to. It's the main entry point for Docker API. It also can be TCP socket but by default for security reasons Docker defaults to use UNIX socket.

Docker cli client uses this socket to execute docker commands by default. You can override these settings as well.

These might be different reasons why you may need to mount Docker socket inside a container. Like launching new container from within another container. Or for auto service discovery and Logging purposes. This increases attack surface so you should be careful if you mount docker socket inside a container there are trusted codes running inside that container otherwise you can simply compromise your host that is running docker daemon, since Docker by default launches all containers as root.

Docker socket has a docker group in most installation so users within that group can run docker commands against docker socket without root permission but actual docker containers still get root permission since docker daemon runs as root effectively (it needs root permission to access namespace and cgroups).

`docker.sock`是Docker守护进程(Docker daemon)默认监听的Unix域套接字(Unix domain socket), 容器中的进程可以通过它与Docker守护进程进行通信

## HTTP请求

安装Docker之后, Docker守护进程会监听Unix域套接字(/var/run/docker.sock), Docker engine API v1.27定义的所有HTTP接口都可以通过`docker.sock`调用

1. 创建容器

curl命令通过Unix套接字发送{"Image":"nginx"}到Docker守护进程的/containers/create接口, 这个将会基于Nginx镜像创建容器并返回容器ID

```
curl -X POST --unix-socket /var/run/docker.sock -d '{"Image":"nginx"}' -H 'Content-Type: application/json' http://localhost/containers/create
```

2. 启动容器

使用返回的容器ID, 调用/containers/start接口, 即可启动新创建的容器

```
curl -X POST --unix-socket /var/run/docker.sock http://localhost/containers/fcb...7d65/start
```

## Docker守护进程的事件流

Docker的API提供了/events接口, 可以用于获取Docker守护进程产生的所有事件流. 负载均衡组件可以通过它获取容器的创建/删除事件, 从而动态地更新配置

1. 运行alpine容器

下面的命令用于运行容器, 并采用交互模式(interactive mode), 同时绑定`docker.sock`
```
docker run -v /var/run/docker.sock:/var/run/docker.sock -ti alpine sh
```

2. 监听Docker守护进程的事件流

在alpine容器内, 可以通过Docker套接字发送HTTP请求到/events接口, 这个命令会一直等待Docker daemon的事件. 当新的事件发生时(例如创建了新的容器), 会看到输出信息
```
curl --unix-socket /var/run/docker.sock http://localhost/events
```
可以观察到3个事件:
> + 创建容器
> + 连接默认的桥接网络 bridge network
> + 启动容器

## Portainer, 集群管理工具

[Portainer](http://portainer.io/), 它提供了图形化界面用于管理Docker主机和Swarm集群, Portainer通过绑定的/var/run/docker.sock文件与Docker守护进程通信，执行各种管理操作。

```
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
```

