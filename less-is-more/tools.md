```
UNetbootin 镜像刻录工具
监视网络流量 netspeed
tty支持中文：cce,zhcon或fbterm
```

## Wicd网络管理器

能够在系统引导时自动连接网络, 可以在静态IP地址和DHCP之间选择, 在连接终止后能够自动恢复, <br/>
支持加密（如WPA1/2、WEP、LEAP、TTLS、EAP、PEAP等）, 可以查看有关网络的信息, <br/>
能够保存不同的静态IP、网关、子网掩码、DNS服务器地址等 <br/>
```
基础软件包：wicd-cli和wicd-curses
GTK客户端：wicd-gtk
KDE客户端：wicd-kde

1. 安装
apt-get install wicd-gtk
2. 设置
关闭network、dhcpbd和networkmanager这些守护程序
systemctl stop netcfg
systemctl stop dhcpcd@.service
systemctl stop NetworkManager.service
禁用这些守护程序
systemctl disable netcfg
systemctl disable dhcpcd@.service
systemctl disable NetworkManager.service
添加服务
systemctl enable wicd.service
添加帐号到netdev组(检查/etc/dbus-1/system.d/wicd.conf中指定的用户组)
gpasswd -a $USERNAME netdev
启动wicd
systemctl start wicd
添加了用户到新组中, 需要登出再登入
运行wicd
wicd-client
如果不需要wicd出现在通知区
wicd-client -n
```

## NVIDIA显卡驱动
```
1. 将开源的NVIDIA驱动nouveau加入黑名单
/etc/modprobe.d/blacklist.conf
blacklist nouveau
2. 查看当前的系统信息
uname -a
系统：kali  内核版本：4.13.0  系统架构：x86_64
3. 安装linux头文件
aptitude -r install linux-header-$(uname -r)
4. 安装nvidia内核
apt-get install nvidia-kernel-4.13.0-kali1-amd64
5. 安装NVIDIA驱动nvidia-kernel-dkms包
aptitude install nvidia-kernel-dkms
6. 安装NVIDIA显卡驱动应用程序nvidia-xconfig包
aptitude install nvidia-xconfig
7. 生成Xorg服务配置文件
nvidia-xconfig
重启系统
8. 检查NVIDIA显卡驱动是否成功安装
先检查GLX模块
glxinfo | grep -i "direct rendering"
检查nvidia驱动模块
lsmod | grep nvidia
lsmod | grep nouveau
9. 为了加快破解一些大数据文件, 需要安装CUDA(Compute Unified Device Architecture)
CUDA是一种由NVIDIA推出的通用并行计算架构, 该架构使GPU能够解决复杂的计算问题
aptitude install nvidia-cuda-toolkit nvidia-opencl-icd
```
