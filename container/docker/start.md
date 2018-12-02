## 开始进入Docker的世界

### 学习资料
1. 博客文章
```
<https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#minimize-the-number-of-layers>
<https://yeasy.gitbooks.io/docker_practice/content/image/build.html>
<https://docs.docker.com/engine/reference/builder/#usage>
```

2. Docker官方英文资源
```
docker官网：http://www.docker.com
Docker windows入门：https://docs.docker.com/windows/
Docker Linux 入门：https://docs.docker.com/linux/
Docker mac 入门：https://docs.docker.com/mac/
Docker 用户指引：https://docs.docker.com/engine/userguide/
Docker 官方博客：http://blog.docker.com/
Docker Hub: https://hub.docker.com/
Docker开源： https://www.docker.com/open-source
```

3. Docker中文资源
```
Docker中文网站：http://www.docker.org.cn
Docker入门教程: http://www.docker.org.cn/book/docker.html
Docker安装手册：http://www.docker.org.cn/book/install.html
一小时Docker教程 ：https://blog.csphere.cn/archives/22
docker从入门到实践：http://dockerpool.com/static/books/docker_practice/index.html
Docker纸质书：http://www.docker.org.cn/dockershuji.html
DockerPPT：http://www.docker.org.cn/dockerppt.html
```

### Docker的安装和卸载
```
//安装
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
deb [arch=amd64] https://download.docker.com/linux/debian stretch stable
apt-get update
apt-get install docker-ce

//卸载
1. apt-get purge docker-ce
2. rm -rf /var/lib/docker
```

### 为什么要用Docker
<pre>
1. docker的轻量级
2. docker的scale out能力, 而且container相对于物理机和虚拟机管理更方便
3. docker作为lxc的管理器, 封装了lxc的技术细节, 将容器技术的使用门槛降低了, 可以快速见到产品的效果
4. docker开源技术的生态越来越好了
</pre>

### Docker介绍

Docker包括三个基本概念 <br/>
> 1. 镜像(Image)
> 2. 容器(Container)
> 3. 仓库(Repository)

#### Docker镜像
<pre>
1)Docker镜像就是一个只读的模板
例如一个镜像可以包含一个完整的ubuntu操作系统环境, 里面仅安装了Apache或用户需要的其它程序
2)镜像可以用来创建Docker容器
Docker提供了一个很简单的机制来创建镜像或者更新现有的镜像
</pre>

#### Docker容器
<pre>
1)Docker利用容器来运行应用
2)容器是从镜像创建的运行实例, 它可以被启动、开始、停止、删除, 每个容器都是相互隔离的、保证安全的平台
3)可以把容器看作一个简易版的Linux环境(包括root用户权限、进程空间、用户空间和网络空间等)和运行在其中的应用程序
</pre>

#### Docker仓库
<pre>
1) 仓库是集中存放镜像文件的场所, 有时候把仓库和仓库注册服务器(Registry)混为一谈, 并不严格区分, 
实际上, 仓库注册服务器上往往存放着多个仓库, 每个仓库又包含了多个镜像, 每个镜像有不同的标签(tag)
2) 仓库分为公开仓库(Public)和私有仓库(Private)两种形式
3) 最大的公开仓库是Docker Hub, 存放了数量庞大的镜像供用户下载
4) 国内的公开仓库包括Docker Pool等
5) 用户可以在本地网络内创建一个私有仓库
</pre>
