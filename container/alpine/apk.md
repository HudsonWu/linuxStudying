# apk, 包管理工具

## 命令简介

### search, 搜索软件包

search命令搜索可用软件包, -v参数输出描述内容, 支持通配符, 
-d或--description参数指定通过软件包描述查询

```
apk search  //查找所有可用软件包
apk search -v  //查找所有可用软件包及其描述内容
apk search -v 'acf*'  //通过软件包名称查找软件包
apk search -v -d 'docker'  //通过描述文件查找特定的软件包
```

### info, 列出PACKAGES或镜像源的详细信息

```
apk info  //列出所有已安装的软件包
apk info -a zlib  //显示完整的软件包信息
apk info --who-owns /sbin/lbu  //显示指定文件属于的包
```

### add, 安装PACKAGES并自动解决依赖关系

add命令从仓库中安装最新软件包, 并安装必须的依赖包, 也可以从第三方仓库添加软件包
```
apk add openssh openntp vim
apk add --no-cache mysql-client
apk add docker --update-cache --repository http://mirrors.ustc.edu.cn/alpine/v3.4/main/ --allow-untrusted
```

安装指定软件包:
```
apk add asterisk=1.6.0.21-r0
apk add 'asterisk<1.6.1'
apk add 'asterisk>1.6.1'
```

### update, 从远程镜像源中更新本地镜像源索引

update命令会从各个镜像源列表下载APKINDEX.tar.gz并存储到本地缓存, 
一般在/var/cache/apk/, /var/lib/apk/, /etc/apk/cache/ 下

### upgrade, 升级当前已安装的软件包

upgrade命令升级系统已安装的所有软件包(一般包括内核), 也可以使用-u或--upgrade指定仅升级部分软件包
```
apk update  //更新本地镜像源索引
apk upgrade  //升级软件, 一般包括内核
apk add --upgrade busybox  //通过-u或--upgrade选择指定部分软件包
```

### del, 卸载并删除PACKAGES
```
apk del openssh openntp vim
```

### 镜像源配置 (`/etc/apk/repositories`)

+ 官方镜像列表: <http://rsync.alpinelinux.org/alpine/MIRRORS.txt>
    + MIRRORS.txt中是当前Alpine官方提供的镜像源(Alpine安装的时候系统自动选择最佳镜像源)
+ 国内镜像源
    + 清华TUNA镜像源: https://mirror.tuna.tsinghua.edu.cn/alpine/
    + 中科大镜像源: http://mirrors.ustc.edu.cn/alpine/
    + 阿里云镜像源: http://mirrors.aliyun.com/alpine/


## 使用实例

```
apk add iproute2 // ss vs netstat
ss -ptl
apk add drill // drill vs nslookup&dig

crond // 开启 cron 服务
crontab -l -e

apk add xxx
apk search -v xxx
apk info -a xxx
apk info
echo -e "http://mirrors.aliyun.com/alpine/v3.6/main\nhttp://mirrors.aliyun.com/alpine/v3.6/community" > /etc/apk/repositories
apk update

// storage
ibu // alpine local backup

// network
echo "shortname" > /etc/hostname
hostname -F /etc/hostname
/etc/hosts
/etc/resolv.conf // conig DNS
modprobe ipv6 // enable ipv6
echo "ipv6" >> /etc/modules
iface // config interface
apk add iptables ip6tables iptables-doc
/etc/init.d/networking restart // activate change
apke add iputils // IPv6 traceroute
traceroute6 ipv6.google.com
awall // alpine wall
// setup a openvpn server

// post-install
/etc/apk/repositories
apk add cherokee --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
apk search -v --description 'NTP' // show description and search from description
apk info -a zlib
apk info -vv|sort
apk info -r -R // require / depency
apk version -v -l '<' // show available updates
apk upgrade -U -a
apk add -u xxx // update xxx

/etc/runlevels // runlevel
apk add openrc // use openrc for init system
rc-update add xxx // set to start on
rc-service xxx start // equal -> /etc/init.d/xxx start
rc-status

adduser xxx
passwd xxx

apk add ansible // server
ssh-keygen
/etc/ansible/hosts
apk add python // node
ssh-copy-id

apk add man man-pages mdocml-apropos less less-doc
export PAGER=less
/etc/rc.conf // /etc/rc.conf -> funny character
apk add bash bash-doc bash-completion // bash
apk add util-linux pciutils usbutils coreutils binutils findutils grep // grep / awk
apk add build-base gcc abuild binutils binutils-doc gcc-doc // compile
apk add cmake cmake-doc extra-cmake-modules extra-cmake-modules-doc
apk add ccache ccache-doc

apk add docker // docker
rc-update add docker boot
rc-service docker start
apk add py-pip
pip install docker-compose
ln -s /usr/bin/docker-compose /usr/bin/doc

// application
apk add openssh // ssh
rc-update add sshd
/etc/init.d/sshd start
/etc/sshd_config
apk add dropbear // another openssh implementation
```

## References

+ [alpine文档](https://wiki.alpinelinux.org/wiki/Developer_Documentation)
