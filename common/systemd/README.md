# systemd, linux服务管理器

+ [systemctl命令](/common/systemd/systemctl.md)
+ [journalctl命令](/common/systemd/journalctl.md)
+ [给程序设置systemd](https://github.com/HudsonWu/linuxStudying/tree/master/common/systemd/service)

## systemd介绍

Systemd是linux系统中最新的初始化系统(init), 它的设计目的就是提高系统的启动速度

## systemd特性

+ 支持并行化任务(更快的启动速度)
+ 采用socket式与D-bus总线式激活服务
+ 按需启动守护进程(daemon)
+ 利用Linux的cgroup监控进程
+ 支持快照和系统恢复
+ 维护挂载点和自动挂载点
+ 各服务间基于依赖关系进行精密控制

## 日志管理

systemd提供了自己的日志系统(logging system), 称为`journal`

默认情况下(当Storage在文件/etc/systemd/journald.conf中被设置为auto), 日志记录将被
写入/var/log/journal/, 该目录是systemd软件包的一部分, 若被删除, systemd不会自动创建它, 
直到下次升级软件包时重建该目录, 如果该目录缺失, systemd会将日志记录写入/run/systemd/journal,
这意味着, 系统重启后日志将丢失

### 日志大小的限制

```
# 可以修改配置文件指定最大限制
# /etc/systemd/journald.conf
SystemMaxUse=50M

# 可以通过配置片段而不是全局配置文件进行设置
# /etc/systemd/journald.conf.d/00-journal-size.conf
[Journal]
SystemMaxUse=50M
```
