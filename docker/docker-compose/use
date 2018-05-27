例子: 启动nginx服务及一个数据卷容器, 并将该数据卷容器作为nginx的静态文件

1. 创建compose文件夹
> mkdir composetest
> cd composetest
2. 创建docker-compose.yml文件
> touch docker-compose.yml
> vim docker-compose.yml
输入以下内容:
> dvc:
>   image: debian:wheezy
>   volumes:
>     - /www:/usr/share/nginx/html:ro
>
> nginx:
>   image: nginx:latest
>   volumes_from:
>     - dvc
>   ports:
>     - "8081:80"
3. 启动
> docker-compose up -d
