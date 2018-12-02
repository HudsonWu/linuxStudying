## docker-compose.yml

每一个定义在docker-compose.yml中的服务必须明确指定一个image或者build选项, <br/>
这与docker run命令中输入的是对应相同的 <br/>
对于docker run, 在Dockerfile文件中指定的选项(如CMD, EXPOSE, VOLUME, ENV)是默认的, <br/>
因此在docker-compose.yml中再指定一次 <br/>

`image`, 标明image的ID, 这个image ID可以是本地也可以是远程的 <br/>
```
image: ubuntu
image: orchardup/postgresql
image: a4bc65fd
```

`build`, 该参数指定Dockerfile文件的路径, 该目录也是发送到守护进程的构建环境 <br/>
compose将会以一个已存在的名称进行构建并标记, 并随后使用这个image <br/>
```
build: /path/to/build/dir
```

`command`, 重写默认的命令 <br/>
```
command: bundle exec thin -p 3000
```

`links`, 连接到其他服务中的容器, 可以指定服务名称和这个链接的别名, 或者只指定服务名称 <br/>
```
links:
  - db
  - db:database
  - redis
```
此时, 在容器内部, 会在/etc/hosts文件中用别名创建一个条目 <br/>
```
172.17.2.186 db
172.17.2.186 database
172.17.2.186 redis
```
环境变量也会被创建

`external_links`, 连接到在这个docker-compose.yml文件或者Compose外部启动的容器 <br/>
特别是对于提供共享和公共服务的容器, 在指定容器名称和别名时, 和links语义用法相同<br/>
```
external_links:
  - redis_1
  - project_db_1:mysql
  - project_db_1:postgresql
```

`ports`, 暴露端口, 指定两者的端口(主机:容器), 或者只是容器的端口(主机会被随机分配一个端口) <br/>
当以主机:容器的形式来映射端口时, 如果使容器的端口小于60, 可能会出现错误, <br/>
因为YAML会将xx:yy这样的数据解析为六十进制的数据, 基于这个原因, 时刻记得要将端口映射明确指定为字符串 <br/>
```
ports:
  - "3000"
  - "8000:8000"
  - "49100:22"
  - "127.0.0.1:8001:8001"
```

`expose`, 暴露端口而不必向主机发布它们, 而只是会向链接的服务(linked service)提供, 只有内部端口可以被指定<br/>
```
expose:
  - "3000"
  - "8000"
```

`volumes`, 挂载路径最为卷, 可以选择性地指定一个主机上的路径(主机:容器), 或是一种可使用的模式(主机:容器:ro) <br/>
```
volumes_from:
  - service_name
  - container_name
```

`environment`, 加入环境变量, 可以使用数组或者字典, 只有一个key的环境变量可以在运行compose的机器上找到对应的值, <br/>
这有助于加密的或者特殊主机的值 <br/>
```
environment:
  RACK_ENV: development
  SESSION_SECRET:
environments:
  - RACK_ENV=development
  - SESSION_SECRET
```

`env_file`, 从一个文件中加入环境变量, 该文件可以是一个单独的值或者一张列表 <br/>
在environment中指定的环境变量将会重写这些值 <br/>
```
env_file:
  - .env

RACK_ENV: development
```

`net`, 网络模式, 可以在docker客户端的--net参数中指定这些值 <br/>
```
net: "bridge"
net: "none"
net: "container: [name or id]"
net: "host"
```

`dns`, 自定义DNS服务, 可以是一个单独的值或者一张列表 <br/>
```
dns: 8.8.8.8
dns:
  - 8.8.8.8
  - 9.9.9.9
```

`cap_add`, `cap_drop`, 加入或者去掉容器能力 <br/>
查看man 7 capabilities可以有一张完整的列表 <br/>
```
cap_add:
  - ALL

cap_drop:
  - NET_ADMIN
  - SYS_ADMIN
```

`dns_search`, 自定义DNS搜索范围, 可以是单独的值或者一张列表 <br/>
```
dns_search: example.com
dns_search:
  - dc1.example.com
  - dc2.example.com
```

`working_dir`, `entrypoing`, `user`, `hostname`, `domainname`, `mem_limit`, <br/>
`privileged`, `restart`, `stdin_open`, `tty`, `cpu_shares` <br/>
上述的每一个都只有一个单独的值, 和docker run中对应的参数一样 <br/>
```
cpu_shares: 73
working_dir: /code
entrypoint: /code/entrypoint.sh
user: postgresql
hostname: foo
domainname: foo.com
mem_limit: 1000000000
privileged: true
restart: always
stdin_open: true
tty: true
```
