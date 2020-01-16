# lxcfs

lxcfs是LXC和LXD的一个附属项目，它基本上是作为一个小的FUSE文件系统挂载到容器中以实现容器内部的proc系统。

社区中常用的做法是利用lxcfs来提供容器中资源的可见性，lxcfs是一个开源的FUSE（用户态文件系统）实现来支持LXC容器，也支持Docker容器。

支持下面的文件：
  + /proc/cpuinfo
  + /proc/diskstats
  + /proc/meminfo
  + /proc/stat
  + /proc/swaps
  + /proc/uptime

## 开始使用lxcfs

### 安装fuse

```
yum install fuse fuse-devel
yum install pam-devel
modprobe fuse
```

### 构建并运行lxcfs

#### 源代码安装

```
git clone git://github.com/lxc/lxcfs
cd lxcfs
./bootstrap.sh
./configure
make
mkdir -p /var/lib/lxcfs
./lxcfs -s -f -o allow_other /var/lib/lxcfs/
```

最后一步如果报没有找到liblxcfs.so文件的错误时：
```
cp .libs/liblxcfs.so /usr/lib/lxcfs/liblxcfs.so
```

后台启动lxcfs：
```
#!/bin/bash
a=`ps -ef|grep /var/lib/lxcfs|grep -v grep|wc -l`
if [ $a -eq 0 ];then
    b=`mount|grep /var/lib/lxc|wc -l`
    if [ $b -ne 0 ];then
        umount /var/lib/lxcfs/
    fi
    rm -rf /var/lib/lxcfs/*
    cd /home/username/lxcfs/lxcfs
    nohup  ./lxcfs -s -f -o allow_other /var/lib/lxcfs/ > /root/lxcfs_startup.log  2>&1 &
fi
```

#### rpm包安装

```
# 安装lxcfs的rpm包
wget https://copr-be.cloud.fedoraproject.org/results/ganto/lxc3/epel-7-x86_64/01041891-lxcfs/lxcfs-3.1.2-0.2.el7.x86_64.rpm
yum install lxcfs-3.1.2-0.2.el7.x86_64.rpm

# 启动lxcfs
lxcfs /var/lib/lxcfs &
```

## 测试lxcfs

```
docker run -it --rm --privileged=true \
    --cpuset-cpus=2-9 -m 1024m \
    -v /var/lib/lxcfs/proc/uptime:/proc/uptime:rw \
    -v /var/lib/lxcfs/proc/cpuinfo:/proc/cpuinfo:rw \
    -v /var/lib/lxcfs/proc/stat:/proc/stat \
    -v /var/lib/lxcfs/cgroup/:/cgroup/:rw \
    -v /var/lib/lxcfs/proc/meminfo:/proc/meminfo \
    -v /var/lib/lxcfs/proc/swaps:/proc/swaps \
    -v /var/lib/lxcfs/proc/diskstats:/proc/diskstats \
    -v /home/username/go/src/runtime:/root/ \
    ubuntu:14.04 /bin/bash
```
