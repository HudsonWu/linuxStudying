Compose环境变量说明

环境变量已经不再是用来连接服务的推荐方法了, 应该使用链接名称(默认情况下是链接服务的名称)作为主机名称来连接
Compose使用Docker links来暴露服务的容器给其他的, 每一个链接的容器都使用了一组环境变量, 这每一组环境变量都是以容器名称的大写字母开头的
要查看服务可用的环境变量, 运行docker-compose run SERVICE env

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
