# linux时间

+ 系统时间: 也叫软件时间(sys), 1970年1月1日到当前时间的秒数
+ BIOS时间: 也叫硬件时间(hc)


## date 和 hwclock

```
# 显示时间
date
hwclock -r

# 设置时间
date -s 20121019
date -s 23:40:00

# ntpdate, 联网更新时间
ntpdate time.windows.com && hwclock -w
# hwclock -w 或 hwclock --systohc 可以做到crontab里
```

## ntpd

```
rpm -qa | grep ntp
chkconfig --list | grep ntp
chkconfig ntpd on
/etc/init.d/ntpd start
```
必要的话设置下/etc/ntp.conf
