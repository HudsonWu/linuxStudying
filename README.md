# The journey of linux

```
           I think Linux is a great thing,
                     in the big picture. It's a great hacker's tool,
                             and it has a lot of potential to become something more.
                                                                            Jamie Zawinski
```

**There are various commands which funny and useful**<br/>

### [常用命令, linux系统之美](https://github.com/HudsonWu/linuxStudying/tree/master/common)
+ [文件相关命令](https://github.com/HudsonWu/linuxStudying/tree/master/common/file)
    + [不同文件搜索命令的异同](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/file_search/file_search_commands.md)
    + [find命令的一些奇技淫巧](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/find.md)
    + [grep, 强大的文本搜索工具](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/grep.md)
    + [sed, 流编辑器](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/sed.md)
    + [awk, 文本文件处理语言](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/awk.md)
    + [touch命令](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/touch.md)
    + [文件时间戳的修改](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/timestamps.md)
    + [rename, 批量重命名](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/rename.md)
    + [dos2unix和unix2dos, 文本格式转换](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/dos2unix.md)
    + [tee, 读取标准输入, 输出到标准输出和文件](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/tee.md)
    + [lsof, 列出当前系统打开的文件](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/lsof.md)
    + [大文件分卷压缩](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/sub_volume.md)
    + [误删除文件恢复](https://github.com/HudsonWu/linuxStudying/tree/master/common/file/delete_mistake)
+ [磁盘检查和操作](https://github.com/HudsonWu/linuxStudying/tree/master/common/disk)
    + [fdisk, 创建和维护分区表](https://github.com/HudsonWu/linuxStudying/tree/master/common/disk/fdisk.md)
    + [du, 显示目录或文件占用的磁盘空间](https://github.com/HudsonWu/linuxStudying/tree/master/common/disk/du.md)
    + [df, 检查文件系统磁盘空间](https://github.com/HudsonWu/linuxStudying/tree/master/common/disk/df.md)
    + [mount, 挂载](https://github.com/HudsonWu/linuxStudying/tree/master/common/disk/mount.md)
    + [挂载实例](https://github.com/HudsonWu/linuxStudying/tree/master/common/disk/examples.md)
+ [进程、任务](https://github.com/HudsonWu/linuxStudying/tree/master/common/process)
    + [top类进程监控工具](https://github.com/HudsonWu/linuxStudying/tree/master/common/process/top.md)
    + [ps, 进程管理](https://github.com/HudsonWu/linuxStudying/tree/master/common/process/ps.md)
    + [kill, 终止进程](https://github.com/HudsonWu/linuxStudying/tree/master/common/process/kill.md)
    + [fg, bf, jobs](https://github.com/HudsonWu/linuxStudying/tree/master/common//process/jobs.md)
    + [supervisor, 进程管理工具](https://github.com/HudsonWu/linuxStudying/tree/master/common/process/supervisor)
+ [查看进度](https://github.com/HudsonWu/linuxStudying/tree/master/common/progress)
    + [progress, 监控命令执行进度](https://github.com/HudsonWu/linuxStudying/tree/master/common/progress/progress.md)
    + [pv, 显示当前命令执行进度](https://github.com/HudsonWu/linuxStudying/tree/master/common/progress/pv.md)
+ [计划任务](https://github.com/HudsonWu/linuxStudying/tree/master/common/schedule)
    + [at, 在指定时间执行任务](https://github.com/HudsonWu/linuxStudying/tree/master/common/schedule/at.md)
    + [crontab, 周期性地执行任务](https://github.com/HudsonWu/linuxStudying/tree/master/common/schedule/crontab.md)
+ [日志管理](https://github.com/HudsonWu/linuxStudying/tree/master/common/log)
    + [日志系统](https://github.com/HudsonWu/linuxStudying/tree/master/common/log/log.md)
    + [history, 历史命令](https://github.com/HudsonWu/linuxStudying/tree/master/common/log/history.md)
    + [logrotate, 日志轮循](https://github.com/HudsonWu/linuxStudying/tree/master/common/log/logrotate.md)
    + [日志清理](https://github.com/HudsonWu/linuxStudying/tree/master/common/log/clean_logs)
+ [服务管理](https://github.com/HudsonWu/linuxStudying/tree/master/common/service)
    + [systemctl命令](https://github.com/HudsonWu/linuxStudying/tree/master/common/service/systemctl.md)
    + [journalctl命令](https://github.com/HudsonWu/linuxStudying/tree/master/common/service/journalctl.md)
    + [给程序设置systemd](https://github.com/HudsonWu/linuxStudying/tree/master/common/service/system)
+ [日期、时区、字符](https://github.com/HudsonWu/linuxStudying/tree/master/common/time)
    + [epoch, unix timestamp](https://github.com/HudsonWu/linuxStudying/tree/master/common/time/epoch.md)
    + [time命令](https://github.com/HudsonWu/linuxStudying/tree/master/common/time/time.md)
    + [linux时间](https://github.com/HudsonWu/linuxStudying/tree/master/common/time/time.md)
    + [字符和时区](https://github.com/HudsonWu/linuxStudying/tree/master/common/time/lang_timezone.md)
    + [ntp, 网络时间协议](https://github.com/HudsonWu/linuxStudying/tree/master/common/time/ntp.md)
+ [数学计算](https://github.com/HudsonWu/linuxStudying/tree/master/common/calc)
    + [bc, 任意精度计算语言](https://github.com/HudsonWu/linuxStudying/tree/master/common/calc/bc.md)
    + [expr, 命令行计数器](https://github.com/HudsonWu/linuxStudying/tree/master/common/calc/expr.md)
+ [正则表达式](https://github.com/HudsonWu/linuxStudying/tree/master/common/re.md)
+ [screen命令](https://github.com/HudsonWu/linuxStudying/tree/master/common/screen.md)
+ [加密和解密](https://github.com/HudsonWu/linuxStudying/tree/master/common/aboutkeys)
    + [Debian中的软件包密钥](https://github.com/HudsonWu/linuxStudying/tree/master/common/aboutkeys/apt-key.md)
    + [GnuPG加密工具](https://github.com/HudsonWu/linuxStudying/tree/master/common/aboutkeys/gpg.md)
    + [openssl加密工具](https://github.com/HudsonWu/linuxStudying/tree/master/common/aboutkeys/openssl.md)
+ [其他一些基本命令](https://github.com/HudsonWu/linuxStudying/tree/master/common/simple)
    + [邮件的使用](https://github.com/HudsonWu/linuxStudying/tree/master/common/simple/mail)
    + [ssh协议](https://github.com/HudsonWu/linuxStudying/tree/master/common/simple/ssh.md)
    + [ssh配置](https://github.com/HudsonWu/linuxStudying/tree/master/common/simple/ssh_config.md)
    + [ftp协议](https://github.com/HudsonWu/linuxStudying/tree/master/common/simple/ftp.md)
    + [用户管理](https://github.com/HudsonWu/linuxStudying/tree/master/common/simple/user_group.md)
    + [简单命令集合](https://github.com/HudsonWu/linuxStudying/tree/master/common/simple/simple.md)

### [bash脚本, linux系统维护利器](https://github.com/HudsonWu/linuxStudying/tree/master/bash)
+ [我写的一些脚本](https://github.com/HudsonWu/linuxStudying/tree/master/bash/my)
+ [expect语言, 自动和交互式任务进行通信](https://github.com/HudsonWu/linuxStudying/tree/master/bash/expect)
+ [一些bash脚本例子](https://github.com/HudsonWu/linuxStudying/tree/master/bash/examples)
+ [shell编程中一些迷惑点](https://github.com/HudsonWu/linuxStudying/tree/master/bash/usage.md)

### [git的使用, 代码版本管理](https://github.com/HudsonWu/linuxStudying/tree/master/git)
+ [一般用法](https://github.com/HudsonWu/linuxStudying/blob/master/git/common.md)
+ [git log的使用](https://github.com/HudsonWu/linuxStudying/blob/master/git/log.md)
+ [处理好分支的合并](https://github.com/HudsonWu/linuxStudying/blob/master/git/merge.md)
+ [远程仓库跟踪](https://github.com/HudsonWu/linuxStudying/blob/master/git/remote.md)
+ [解决实际问题](https://github.com/HudsonWu/linuxStudying/blob/master/git/attention.md)
+ [撤销、回退以及进度保存](https://github.com/HudsonWu/linuxStudying/blob/master/git/checkout.md)
+ [git使用中的一些配置](https://github.com/HudsonWu/linuxStudying/blob/master/git/conf.md)
+ [标签的使用](https://github.com/HudsonWu/linuxStudying/blob/master/git/tag.md)

### [容器的学习](https://github.com/HudsonWu/linuxStudying/tree/master/container)
+ [docker, 开源容器解决方案](https://github.com/HudsonWu/linuxStudying/tree/master/container/docker)
+ [kubernetes, 容器化应用程序的自动部署、扩展和管理](https://github.com/HudsonWu/linuxStudying/tree/master/container/kubernetes)

### [网络相关命令, 网络的监控、安全攻防](https://github.com/HudsonWu/linuxStudying/tree/master/network)
+ [命令行下的web访问](https://github.com/HudsonWu/linuxStudying/tree/master/network/http)
+ [web服务器的一些配置, 性能优化之路](https://github.com/HudsonWu/linuxStudying/tree/master/network/webservers)

### [vim编辑器, 命令行下强大的文本编辑器](https://github.com/HudsonWu/linuxStudying/tree/master/vim)

### [关系型数据库, 结构化查询语言](https://github.com/HudsonWu/linuxStudying/tree/master/rdbms)

### [markdown, 轻量级标记语言](https://github.com/HudsonWu/linuxStudying/tree/master/markdown)
+ [基本语法](https://github.com/HudsonWu/linuxStudying/blob/master/markdown/how.md)
+ [实际使用](https://github.com/HudsonWu/linuxStudying/blob/master/markdown/use.md)

### [windows的一些便利用法](https://github.com/HudsonWu/linuxStudying/tree/master/windows)
+ [批处理文件](https://github.com/HudsonWu/linuxStudying/tree/master/windows/bat)

## About me
a linux lover, a dreaming man, <br/>

> Before you can run, you need to be able to walk </br>
