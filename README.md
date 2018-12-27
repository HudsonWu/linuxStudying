# The Journey of Linux

```
           I think Linux is a great thing,
                     in the big picture. It's a great hacker's tool,
                             and it has a lot of potential to become something more.
                             
                                                                            Jamie Zawinski
```

**There are various commands which funny and useful**


## Table of Contents

---
> + [Linux下高效工作](#Linux下高效工作)
> + [Bash脚本, Linux系统维护利器](#Bash脚本-Linux系统维护利器)
> + [Container, A standardized unit of software](#Container)
> + [Linux性能分析和工具](#Linux性能分析和工具)
> + [网络的学习和相关命令](#网络管理)
> + [文件的查找和操作](#Linux系统下的文件管理)
> + [web服务, 服务器, 容器, 中间件](#web技术)
> + [基础命令, 开启Linux之旅](#基础命令-开启Linux之旅)
> + [其他一些相关知识的学习](#其他深入的学习)
---

### [Linux下高效工作](./efficiency)

+ [正则表达式, 检索、替换符合某个模式的文本](./efficiency/regular_expression)
    + [regular expression](/efficiency/regular_expression/overview.md)
+ [Jenkins, 持续集成/持续交付工具](./efficiency/jenkins)
    + [Tutorials](/efficiency/jenkins/guide.md)
    + [Jenkinsfile](/efficiency/jenkins/Jenkinsfile-example)
+ [git, 分布式代码版本管理工具](./efficiency/git)
    + [一般用法](/efficiency/git/common.md)
    + [git log的使用](/efficiency/git/log.md)
    + [处理好分支的合并](/efficiency/git/merge.md)
    + [远程仓库跟踪](/efficiency/git/remote.md)
    + [撤销、回退以及进度保存](/efficiency/git/checkout.md)
    + [git使用中的一些配置](/efficiency/git/conf.md)
    + [标签的使用](/efficiency/git/tag.md)
    + [plumbing, 底层命令](/efficiency/git/plumbing_commands.md)
    + [版本, 引用](/efficiency/git/revision.md)
    + [解决实际问题](/efficiency/git/attention.md)
    + [一些命令集合](/efficiency/git/some_commands.md)
+ [vim, 命令行下强大的文本编辑器](./efficiency/vim)
    + [学会vim内部帮助命令](/efficiency/vim/help.md)
    + [命令模式下一些实用的命令](/efficiency/vim/cmd.md)
    + [普通模式下一些常用的快键键](/efficiency/vim/normal.md)
    + [vim中的编码问题](/efficiency/vim/encoding.md)
    + [vim打开或编辑多个文件](/efficiency/vim/multifile.md)
    + [插件管理](/efficiency/vim/plugins.md)
    + [vimrc配置文件(不使用插件)](/efficiency/vim/vimrc)
    + [vimrc配置文件(使用插件)](/efficiency/vim/init.vim)
+ [Linux命令使用技巧](/efficiency/tricks.md)
+ [使用screen管理你的远程会话](/efficiency/screen.md)
+ [Markdown, 轻量级标记语言](./efficiency/vim)
    + [基本语法](/efficiency/markdown/syntax.md)
    + [实际使用](/efficiency/markdown/solve.md)
+ [命令执行进度的监控](./efficiency/progress)
    + [progress, 监控命令执行进度](/efficiency/progress/progress.md)
    + [pv, 显示当前命令执行进度](/efficiency/progress/pv.md)

### [Bash脚本-Linux系统维护利器](./bash)

+ [我写的一些脚本](./bash/my)
    + [实践中的一些脚本](./bash/my/practical)
        + [vue代码自动打包提交](/bash/my/practical/vue_build.sh)
        + [代码更新功能封装](/bash/my/practical/update_git.sh)
        + [日志文件大于20MiB时备份](/bash/my/practical/bak_log.sh)
        + [操作mysql](/bash/my/practical/do_sql.sh)
        + [开启指定目录的队列](/bash/my/practical/queue.sh)
        + [laraval代码更新](/bash/my/practical/php_update.sh)
    + [fortune和cowsay](./bash/my/cowsay)
        + [依次使用所有的cowfile打印显示处fortune命令下的文字](/bash/my/cowsay/all_cowsay.sh)
        + [随机使用cowfile打印显示出fortune命令下的文字](/bash/my/cowsay/random_cowsay.sh)
    + [根据mtime备份.vimrc文件](./bash/my/autobak_vimrc)
+ [expect语言, 自动和交互式任务进行通信](./bash/expect)
+ [shell编程中一些有用的知识点](/bash/usage.md)
+ [判断变量是否为空](/bash/if_null.md)
+ [shell中各种括号的运用](/bash/brackets.md)
+ [set, env, export的区分](/bash/env_vars.md)
+ [一些bash脚本例子](./bash/examples)
+ [Linux中的shell](/bash/shell.md)

### [Container](./container)

+ [docker, 开源容器解决方案](./container/docker)
    + [docker-compose环境搭建](./container/docker/docker-compose)
        + [docker-compose概览](/container/docker/docker-compose/overview.md)
        + [docker-compose命令介绍](/container/docker/docker-compose/cli.md)
        + [docker-compose.yml配置文件](/container/docker/docker-compose/yml.md)
        + [docker-compose使用实例](./container/docker/docker-compose/examples)
    + [Docker是什么](/container/docker/start.md)
    + [Docker的常用命令](/container/docker/commands.md)
    + [Docker容器的日志查看和清理](/container/docker/logs.md)
    + [docker.sock, unix套接字](/container/docker/socket.md)
    + [解决实际问题](/container/docker/solve.md)
    + [dvwa的docker搭建实例](/container/docker/dvwa.md)
    + [Dockerfile文件](./container/docker/Dockerfiles)
        + [Dockerfile介绍](/container/docker/Dockerfiles/introduction.md)
        + [CMD和ENTRYPOINT](/container/docker/Dockerfiles/entrypoint.md)
        + [多阶段镜像构建](/container/docker/Dockerfiles/multi-stage.md)
        + [Dockerfile实例](./container/docker/Dockerfiles/examples)
+ [kubernetes, 容器化应用程序的自动部署、扩展和管理](./container/kubernetes)
    + [安装和配置](/container/kubernetes/start.md)
    + [一些概念](/container/kubernetes/concepts.md)
    + [负载均衡](/container/kubernetes/load_balance.md)
    + [kubernetes简单示例](./container/laravel_k8s)
+ [Alpine Linux, 轻型Linux发行版](./container/alpine)

### [Linux性能分析和工具](./performance)

+ [进程监控和管理](./performance/process)
    + [ps, 进程查看器](/performance/process/ps.md)
    + [pstree, 以树状图显示进程间关系](/performance/process/pstree.md)
    + [lsof, list open files](/performance/process/lsof.md)
    + [kill, 终止进程](/performance/process/kill.md)
    + [fg, bg, jobs](//performance/process/jobs.md)
    + [IPC, 进程间通信](/performance/process/ipc.md)
    + [supervisor, 进程管理工具](./performance/process/supervisor)

### [网络管理](./network)

+ [netcat, 网络工具中的瑞士军刀](/network/netcat.md)
+ [iproute2工具包, 管理网络和流量统计](./network/iproute2)
    + [iproute2工具包介绍](/network/iproute2/overview.md)
    + [理解一些概念](/network/iproute2/concepts.md)
    + [iproute2命令集](/network/iproute2/commands.md)
    + [ip命令](/network/iproute2/ip.md)
    + [tc命令](/network/iproute2/tc.md)
    + [ss, 显示活动的网络连接](/network/iproute2/ss.md)
+ [网络监控工具](./network/monitor)
    + [监控工具概览](/network/monitor/overview.md)
+ [iptables, 命令行防火墙工具](./network/iptables)
    + [iptables原理分析](/network/iptables/principle.md)
    + [iptables命令使用](/network/iptables/use.md)
    + [firewalld, iptables的前端控制器](./network/iptables/firewalld)
        + [firewalld原理分析](/network/iptables/firewalld/theory.md)
        + [firewall-cmd命令使用](/network/iptables/firewalld/use.md)
+ [snmp, 简单网络管理协议](./network/snmp)
    + [snmp协议介绍](/network/snmp/overview.md)
    + [net-snmp工具](/network/snmp/net-snmp.md)
    + [安装与使用](/network/snmp/use.md)
+ [无线网络](./network/wireless)
    + [连接到wireless network](/network/wireless/wireless.md)
    + [wpa_supplicant, 无线网络管理和配置工具](/network/wireless/wpa_supplicant)
    + [配置文件](./network/wireless/conf)

### [Linux系统下的文件管理](./file)

+ [file system, 文件系统](./file/fs)
+ [误删除文件恢复](./file/delete_mistake)
+ [tee, 读取标准输入, 输出到标准输出和文件](/file/tee.md)
+ [大文件分卷压缩](/file/sub_volume.md)
+ [reflink, copy on write](/file/reflink.md)
+ [fallocate, 预分配或重新分配空间给文件](/file/fallocate.md)
+ [find, locate, whereis, which](/file/file_search/commands.md)
+ [find命令的深入学习](/file/file_search/find.md)
+ [grep, 强大的文本搜索工具](/file/grep.md)
+ [sed, 流编辑器](/file/sed.md)
+ [awk, 文本文件处理语言](/file/awk.md)
+ [touch命令](/file/touch.md)
+ [文件时间戳的修改](/file/timestamps.md)
+ [rename, 批量重命名](/file/rename.md)
+ [dos2unix和unix2dos, 文本格式转换](/file/dos2unix.md)

### [web技术](./web)

+ [web服务器](./web/web_server)
    + [Nginx, 高性能的HTTP和反向代理服务](./web/web_server/nginx)
        + [nginx简单介绍](/web/web_server/nginx/overview.md)
        + [访问加速的相关配置](/web/web_server/nginx/speed.md)
        + [fastcgi模块主要指令](/web/web_server/nginx/fastcgi_directives.md)
        + [理解Nginx配置文件里指令的继承关系](/web/web_server/nginx/inheritance.md)
        + [配置url重写](/web/web_server/nginx/rewrite.md)
        + [nginx配置文件实例](./web/web_server/nginx/conf_examples)
    + [Caddy, The HTTP/2 Web Server with Automatic HTTPS](./web/web_server/caddy)
+ [HTTP命令行客户端](./web/client)
    + [curl, 数据传输工具](./web/client/curl)
        + [基本用法](./web/client/curl/basic.md)
        + [实用技巧](./web/client/curl/tricks.md)
    + [httpie, http命令行客户端](/web/client/httpie.md)
    + [urlencode编码与解码](/web/client/urlencode.md)
+ [web缓存, HTTP代理, 代理服务器](./web/caching)

### [基础命令-开启Linux之旅](./common)

+ [一些基础命令](/common/some_commands.md)
+ [用户管理](/common/user_group.md)
+ [计划任务](./common/schedule)
    + [at, 在指定时间执行任务](/common/schedule/at.md)
    + [crontab, 周期性地执行任务](/common/schedule/crontab.md)
+ [服务管理](./common/service)
    + [systemctl命令](/common/service/systemctl.md)
    + [journalctl命令](/common/service/journalctl.md)
    + [给程序设置systemd](./common/service/system)
+ [日志管理](./common/log)
    + [日志系统](/common/log/log.md)
    + [history, 历史命令](/common/log/history.md)
    + [logrotate, 日志轮循](/common/log/logrotate.md)
    + [日志清理](./common/log/clean_logs)
+ [日期、时区、字符](./common/time)
    + [epoch, unix timestamp](/common/time/epoch.md)
    + [time命令](/common/time/time.md)
    + [Linux时间](/common/time/time.md)
    + [字符和时区](/common/time/lang_timezone.md)
    + [ntp, 网络时间协议](/common/time/ntp.md)
+ [数学计算](./common/calc)
    + [bc, 任意精度计算语言](/common/calc/bc.md)
    + [expr, 命令行计数器](/common/calc/expr.md)
+ [加密和解密](./common/aboutkeys)
    + [Debian中的软件包密钥](/common/aboutkeys/apt-key.md)
    + [GnuPG加密工具](/common/aboutkeys/gpg.md)
    + [openssl加密工具](/common/aboutkeys/openssl.md)
+ [Linux邮件功能](./common/mail)
    + [Linux下的邮件配置](/common/schedule/mail/config.md)
    + [mail命令](/common/schedule/mail/mail.md)
    + [postfix](/common/schedule/mail/postfix.md)
+ [ssh和ftp](./common/mail)
    + [ssh协议](/common/ssh_and_ftp/ssh.md)
    + [ftp实际使用](/common/ssh_and_ftp/ftp.md)
    + [scp命令](/common/ssh_and_ftp/scp.md)
    + [ssh配置](/common/ssh_and_ftp/config_ssh.md)

### [其他一些相关知识的学习](https://github.com/linuxStudying/tree/less-is-more)

+ [关系型数据库, 结构化查询语言](./less-is-more/rdbms)
+ [windows的一些便利用法](./less-is-more/windows)
    + [批处理文件](./less-is-more/windows/bat)

### [回到主目录](#Table-of-Contents)

## About

这里展示的, 是我在Linux学习过程中的简要笔记, 对于我的帮助有三, 一是学习过程中能加深印象, 二是能时时回来温习下, 三是让我对Linux知识有一个系统性的梳理

### About me

我是一位Linux爱好者, 喜欢在命令行下工作, 因为其便捷、功能强大. 在Linux生态圈遨游的过程中, 总会有各种各样奇妙、高级的思想让我惊叹, 让我兴奋, 让我知道学无止境. Linux的学习就是不断地实践, 然后遇到各种错误, 首先尝试独立去解决问题, 然后再看看其他人是怎样应对的, 在解决问题中熟悉各种概念, 知道解决问题的不同方案, 当你有了一定的积累后, 就能熟练地使用这些掌握到的知识去应对出现的各种情况, 满足各种不同的需求. 初级阶段熟练地使用各种强大的工具, 到一定程度就需要独立开发出更加个性化的工具, 满足特定需求, 学习过程是漫长的, 知识的海洋是无穷的

a Linux lover, a dreaming man, 

> Before you can run, you need to be able to walk

