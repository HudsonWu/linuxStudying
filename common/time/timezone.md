## 时区
1. 显示时区
> date -R
> date +%z
+0800 东八区
2. 修改时区
> cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
时区的信息存在/usr/share/zoneinfo目录下, 本机的时区信息存在/etc/localtime文件
OR
> tzselect  //互动式命令

## 时间
linux时间有两个:
+ 系统时间: 也叫软件时间(sys), 1970年1月1日到当前时间的秒数
+ BOIS时间: 也叫硬件时间(hc)
1. 显示时间
> date
> hwclock -r
2. 设置时间
date -s, 没有网络的情况下可以用这个
> date -s 20121019
> date -s 23:40:00
ntpdate, 联网更新时间
> ntpdate time.windows.com && hwclock -w
hwclock -w 或 hwclock --systohc 可以做到crontab里
启动ntpd服务
> rpm -qa | grep ntp
> chkconfig --list | grep ntp
> chkconfig ntpd on
> /etc/init.d/ntpd start
必要的话设置下/etc/ntp.conf

