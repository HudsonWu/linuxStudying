# Alpine Linux, Small. Simple. Secure.

```
Alpine Linux is a security-oriented, lightweight linux distribution based on musl libc and busybox
```

Alpine Linux 操作系统是一个面向安全的轻型Linux发行版, 采用了musl libc和busybox以减少系统的体积和运行时资源消耗 <br/>
它特别为资深/重度Linux用户而优化, 关注安全, 性能和资源效能, 是一个优秀的可以适用于生产的基础系统/环境 <br/>

## 软件包安装

```
//使用主索引(https://pkgs.alpine.org/packages)
apk add --no-cache <package>

//使用测试或社区索引
echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk --update add --no-cache <package>
```

## 相关资源

> + 官网: <https://alpinelinux.org/>
> + 软件安装包(主索引): <https://pkgs.alpinelinux.org/packages>
> + Github: <https://github.com/alpinelinux>
> + Docker官方镜像: <https://hub.docker.com/_/alpine/>
> + 官方镜像仓库: <https://github.com/gliderlabs/docker-alpine>
