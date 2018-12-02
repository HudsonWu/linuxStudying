## docker-compose的安装

### compose安装

在安装compose之前, 确保已经安装了docker1.3或以上版本 <br/>
```
curl -L https://github.com/docker/compose/releases/download/ \
    1.1.0/docker-compose-`uname -s`-`uname -m`> /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### compose命令补全

确保bash-completion已经安装, 然后将compose的completion脚本放在/etc/bash_completion.d/下: <br/>
```
> curl -L https://raw.githubusercontent.com/docker/compose/1.1.0/contrib/ \
    completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
```
下次登录时, Completion功能就可以使用了 <br/>

## docker-compose使用实例

启动nginx服务及一个数据卷容器, 并将该数据卷容器作为nginx的静态文件 <br/>

1. 创建compose文件夹
```
mkdir composetest
cd composetest
```

2. 创建docker-compose.yml文件
```
touch docker-compose.yml
vim docker-compose.yml
```
输入以下内容
```
dvc:
  image: debian:wheezy
  volumes:
    - /www:/usr/share/nginx/html:ro
>
nginx:
  image: nginx:latest
  volumes_from:
    - dvc
  ports:
    - "8081:80"
```

3. 启动
```
docker-compose up -d
```

## Compose环境变量说明

环境变量已经不再是用来连接服务的推荐方法了, <br/>
应该使用链接名称(默认情况下是链接服务的名称)作为主机名称来连接 <br/>
Compose使用Docker links来暴露服务的容器给其他的, 每一个链接的容器都使用了一组环境变量, <br/>
这每一组环境变量都是以容器名称的大写字母开头的 <br/>
要查看服务可用的环境变量, 运行docker-compose run SERVICE env <br/>

```
name_PORT, 完整URL
> DB_PORT=tcp://172.17.0.5:5432

name_PORT_num_protocol, 完整URL
> DB_PORT_5432_TCP=tcp://172.17.0.5:5432

name_PORT_num_protocol_ADDR, 容器的IP地址
> DB_PORT_5432_TCP_ADDR=172.17.0.5

name_PORT_num_protocol_PORT, 暴露的端口号
> DB_PORT_5432_TCP_PORT=5432

name_PORT_num_protocol_PROTO, 协议(tcp或udp)
> DB_PORT_5432_TCP_PROTO=tcp

name_NAME, 完全合格的容器名称
> DB_1_NAME=/myapp_web_1/myapp_db_1
```
