# shadowsocksr服务端安装

## 基本库

如果要使用salsa20或chacha20或chacha20-ietf算法, 请安装libsodium

1. 从软件源安装libsodium和一些依赖工具
```sh
yum install m2crypto git libsodium
yum -y groupinstall “Development Tools

apt-get install python-m2crypto libsodium-dev git
```

2. 源代码安装libsodium
```sh
wget https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz
tar xf libsodium-1.0.10.tar.gz && cd libsodium-1.0.10
./configure && make -j2 && make install
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
ldconfig
```

## 服务端配置和开启

1. 获取shadowsocksr源代码

```sh
git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git
```

2. 开启shadowsocksr服务端

```sh
//进入根目录初始化配置
bash initcfg.sh

//进入shadosocks子目录, 开启shadowsocksr服务端
python server.py -p 443 -k password -m aes-256-cfb -O auth_sha1_v4 -o http_simple
```
-p 端口 -k 密码 -m 加密方式 -O 协议插件  -o 混淆插件

## 服务管理

```
//后台运行
python server.py -p 46176 -k strongPassword -m aes-256-cfb -O auth_sha1_v4 -o tls1.2_ticket_auth -d start

//停止/重启
python server.py -d stop/restart

//查看日志
tail -f /var/log/shadowsocksr.log
```
