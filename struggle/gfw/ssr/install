centos安装shadowsocksr服务端

1. 基本库安装
如果要使用salsa20或chacha20或chacha20-ietf算法, 请安装libsodium
> yum install m2crypto git libsodium  //redhat
> yum -y groupinstall “Development Tools
> apt-get install python-m2crypto libsodium-dev git  //debian
> // source code install
> wget https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz
> tar xf libsodium-1.0.10.tar.gz && cd libsodium-1.0.10
> ./configure && make -j2 && make install
> echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
> ldconfig


2. 获取源代码
> git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git

3. 服务端配置
进入根目录初始化配置:
> bash initcfg.sh
进入shadosocks子目录:
> python server.py -p 443 -k password -m aes-256-cfb -O auth_sha1_v4 -o http_simple
-p 端口 -k 密码 -m 加密方式 -O 协议插件  -o 混淆插件
