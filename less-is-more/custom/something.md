## VirtualBox增强功能

1. 在线安装
```
apt-get install -y virtualbox-guest-x11
reboot
```

2. 自带包安装
```
apt-get update && apt-get install -y linux-header-$(uname -r)
cp /media/cd-rom/VBoxLinuxAdditions.run /root/
chmod 755 /root/VBoxLinuxAdditions.run
cd /root
./VBoxLinuxAdditions.run
```

## 开启系统的路由转发功能
```
vi /etc/sysctl.conf
net.ipv4.ip_forward=1
```
