```
UNetbootin 镜像刻录工具
监视网络流量 netspeed
tty支持中文：cce,zhcon或fbterm
```

## [aria2](https://aria2.github.io)

lightweight multi-protocol multi-source command-line download utility

The mainline DHT bootstrap nodes: (port: 6881)
```
 dht.transmissionbt.com
 router.utorrent.com
 router.bittorrent.com
```

Configuring aria2: ~/.aria2/aria2.conf
```
 enable-xml-rpc
 follow-torrent=mem
 seed-ratio=2
```

1. Download from WEB
```
aria2c http://example.org/mylinux.iso
```
2. Download from 2 sources
```
aria2c http://a/f.iso ftp://b/f.iso
```
3. Download using 2 connections per host
```
aria2c -x2 http://a/f.iso
```
4. BitTorrent
```
aria2c linux-dist.torrent  (already have a torrent file)
aria2c http://example.org/mylinux.torrent  (download the torrent file and start downloading data)
aria2c --follow-torrent=mem http://local/linux-dist.torrent  (the actual torrent file will be stored into a memory only,and discarded when downloading is finished)
```
5. BitTorrent Magnet URI
```
aria2c 'magnet:?xt=urn:btin:248D0A1CD08284299DE78D5C1ED359BB46717D8C'
```
6. Metalink
```
aria2c http://example.org/mylinux.metalink
```
7. Download URIs found in text file
```
aria2c -i uris.txt
```

## w3m, preview HTML documents from the command line

```
sudo apt-get install w3m
w3m -dump askubuntu.com | less
w3m -dump index.html | less
w3m -dump -cols 200 file.html  (set the number of columns)
```

## redshift

```
https://github.com/jonls/redshift
```

## namebench, find the best DNS servers to use

```
sudo apt-get install python-tk
wget http://namebench.googlecode.com/files/namebench-1.3.1-source.tgz
tar xvfvz namebench-1.3.1-source.tgz
cd namebench-1.3.1
./namebench.py
```

## chrome

1. 将下载源加入到系统的源列表
```
sudo wget https://repo.fdzh.org/chrome/google-chrome.list \
-P /etc/apt/sources.list.d/
```

2. 导入谷歌软件的公钥
```
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  \
| sudo apt-key add -
```

3. 更新系统的可用更新列表
```
sudo apt-get update
```

4. 安装chrome稳定版
```
sudo apt-get install google-chrome-stable
```

5. 打开
```
/usr/bin/google-chrome-stable
```

## NVIDIA显卡驱动

1. 将开源的NVIDIA驱动nouveau加入黑名单
```
// vi /etc/modprobe.d/blacklist.conf
blacklist nouveau
```

2. 查看当前的系统信息
```
uname -a
```

3. 安装linux头文件
```
aptitude -r install linux-header-$(uname -r)
```

4. 安装nvidia内核
```
apt-get install nvidia-kernel-4.13.0-kali1-amd64
```

5. 安装NVIDIA驱动nvidia-kernel-dkms包
```
aptitude install nvidia-kernel-dkms
```

6. 安装NVIDIA显卡驱动应用程序nvidia-xconfig包
```
aptitude install nvidia-xconfig
```

7. 生成Xorg服务配置文件
```
nvidia-xconfig
```
然后重启系统

8. 检查NVIDIA显卡驱动是否成功安装
```
//先检查GLX模块
glxinfo | grep -i "direct rendering"
//检查nvidia驱动模块
lsmod | grep nvidia
lsmod | grep nouveau
```

9. 为了加快破解一些大数据文件, 需要安装CUDA(Compute Unified Device Architecture)

CUDA是一种由NVIDIA推出的通用并行计算架构, 该架构使GPU能够解决复杂的计算问题
```
aptitude install nvidia-cuda-toolkit nvidia-opencl-icd
```
