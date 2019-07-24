# journalctl 

```
/etc/systemd/journald.conf

//查看所有日志
(默认情况下只保存本次启动的日志)
> journalctl

//--dmesg或-k, 查看内核日志, 
(不显示应用日志)
> journalctl -k

//--system或-b, 查看系统本次启动的日志 
(包括内核日志和各类系统服务的控制台输出)
> journalctl -b
> journalctl -b -0
> journalctl -b -1  //查看上一次启动的日志(需更改设置)

//--unit或-u, 查看指定服务的日志
> journalctl -u docker.service
> journalctl /usr/lib/systemd/systemd

//实时滚动显示最新日志
> journalctl -f

//查看指定时间的日志
> journalctl --since="2012-10-30 18:17:16"
> journalctl --since="20 min ago"
> journalctl --since="yesterday"
> journalctl --since "2015-01-10" --until "2015-01-11 03:00"
> journalctl --since 09:00 --until "1 hour ago"

//--lines或-n, 显示尾部的最新10行日志
> journalctl -n
> journalctl -n 20  //显示尾部指定行数的日志

//将最新的日志显示在前面
> journalctl -r -u docker.service

//--output 或-o, 改变输出的格式 
> journalctl -r -u docker.service -o json-pretty

//查看指定进程的日志
> journalctl _PID=1

//查看某个路径的脚本日志
> journalctl /usr/bin/bash

//查看指定用户的日志
> journalctl _UID=33 --since today

//查看某个unit的日志
> journalctl -u nginx.service
> journalctl -u nginx.service --since today
> journalctl -u nginx.service -f  //实时滚动显示某个unit最新日志
> journalctl -u nginx.service -u php-fpm.service --since today  //合并显示多个unit的日志

//查看指定优先级 (及其以上级别)的日志
0 emerg
1 alert
2 crit
3 err
4 warning
5 notice
6 info
7 debug
> journalctl -p err -b
//--no-pager改为正常的标准输出 (日志默认分页输出)
> journalctl --no-pager
//以JSON格式 (单行)输出
> journalctl -b -u nginx.service -o json
//以JSON格式 (多行)输出
> journalctl -b -u nginx.service -o json-pretty
//显示日志占据的硬盘空间
> journalctl --disk-usage
//指定日志文件占据的最大空间
> journalctl --vacuum-size=1G
//指定日志保存多久
> journalctl --vacuum-time=1years
```

## 日志

```
# 检查当前journal使用磁盘量
journalctl --disk-usage

# 按照时间清理
journalctl --vacuum-time=2d

# 按照容量清理
journalctl --vacuum-size=500M

# 如果要手工删除日志文件, 删除前需要先轮转一次journal日志
systemctl kill --kill-who=main --signal=SIGUSR2 systemd-journald.service

# 启用日志限制持久化配置, 修改/etc/systemd/journald.conf
# 然后重启systemctl restart systemd-journald.service
SystemMaxUse=16M
ForwardToSyslog=no

# 检查journal是否运行正常以及日志文件是否完整无损坏
journalctl --verify
```
