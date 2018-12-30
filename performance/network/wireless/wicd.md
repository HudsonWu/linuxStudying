# Wicd, 网络管理器

能够在系统引导时自动连接网络, 可以在静态IP地址和DHCP之间选择, 在连接终止后能够自动恢复; 支持加密（如WPA1/2、WEP、LEAP、TTLS、EAP、PEAP等）, 可以查看有关网络的信息; 能够保存不同的静态IP、网关、子网掩码、DNS服务器地址等

+ 基础软件包: wicd-cli和wicd-curses
+ GTK客户端: wicd-gtk
+ KDE客户端: wicd-kde

```
1. 安装
apt-get install wicd-gtk wicd-cli wicd-curses
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
