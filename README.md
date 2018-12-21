# The journey of linux

```
           I think Linux is a great thing,
                     in the big picture. It's a great hacker's tool,
                             and it has a lot of potential to become something more.
                             
                                                                            Jamie Zawinski
```

**There are various commands which funny and useful**


### [Linux下高效工作](https://github.com/HudsonWu/linuxStudying/tree/master/efficiency)

+ [linux命令使用技巧](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/tricks.md)
+ [使用screen管理你的远程会话](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/screen.md)
+ [git, 分布式代码版本管理工具](https://github.com/HudsonWu/linuxStudying/tree/master/efficiency/git)
    + [一般用法](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/common.md)
    + [git log的使用](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/log.md)
    + [处理好分支的合并](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/merge.md)
    + [远程仓库跟踪](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/remote.md)
    + [撤销、回退以及进度保存](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/checkout.md)
    + [git使用中的一些配置](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/conf.md)
    + [标签的使用](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/tag.md)
    + [plumbing, 底层命令](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/plumbing_commands.md)
    + [版本, 引用](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/revision.md)
    + [解决实际问题](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/attention.md)
    + [一些命令集合](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/git/some_commands.md)
+ [vim, 命令行下强大的文本编辑器](https://github.com/HudsonWu/linuxStudying/tree/master/efficiency/vim)
    + [学会vim内部帮助命令](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/vim/help.md)
    + [命令模式下一些实用的命令](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/vim/cmd.md)
    + [普通模式下一些常用的快键键](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/vim/normal.md)
    + [vim中的编码问题](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/vim/encoding.md)
    + [vim打开或编辑多个文件](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/vim/multifile.md)
    + [插件管理](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/vim/plugins.md)
    + [vimrc配置文件(不使用插件)](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/vim/vimrc)
    + [vimrc配置文件(使用插件)](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/vim/init.vim)
+ [正则表达式, 检索、替换符合某个模式的文本](https://github.com/HudsonWu/linuxStudying/tree/master/efficiency/regular_expression)
    + [regular expression](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/regular_expression/overview.md)
+ [Markdown, 轻量级标记语言](https://github.com/HudsonWu/linuxStudying/tree/master/efficiency/vim)
    + [基本语法](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/markdown/syntax.md)
    + [实际使用](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/markdown/solve.md)
+ [Jenkins, 持续集成/持续交付工具](https://github.com/HudsonWu/linuxStudying/tree/master/efficiency/jenkins)
    + [Tutorials](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/jenkins/guide.md)
    + [Jenkinsfile](https://github.com/HudsonWu/linuxStudying/blob/master/efficiency/jenkins/Jenkinsfile-example)

### [bash脚本, linux系统维护利器](https://github.com/HudsonWu/linuxStudying/tree/master/bash)

+ [我写的一些脚本](https://github.com/HudsonWu/linuxStudying/tree/master/bash/my)
    + [fortune和cowsay](https://github.com/HudsonWu/linuxStudying/tree/master/bash/my/cowsay)
        + [依次使用所有的cowfile打印显示处fortune命令下的文字](https://github.com/HudsonWu/linuxStudying/blob/master/bash/my/cowsay/all_cowsay.sh)
        + [随机使用cowfile打印显示出fortune命令下的文字](https://github.com/HudsonWu/linuxStudying/blob/master/bash/my/cowsay/random_cowsay.sh)
    + [根据mtime备份.vimrc文件](https://github.com/HudsonWu/linuxStudying/tree/master/bash/my/autobak_vimrc)
    + [实践中的一些脚本](https://github.com/HudsonWu/linuxStudying/tree/master/bash/my/practical)
        + [日志文件大于20MiB时备份](https://github.com/HudsonWu/linuxStudying/blob/master/bash/my/practical/bak_log.sh)
        + [vue代码自动打包提交](https://github.com/HudsonWu/linuxStudying/blob/master/bash/my/practical/vue_build.sh)
        + [操作mysql](https://github.com/HudsonWu/linuxStudying/blob/master/bash/my/practical/do_sql.sh)
        + [开启指定目录的队列](https://github.com/HudsonWu/linuxStudying/blob/master/bash/my/practical/queue.sh)
        + [laraval代码更新](https://github.com/HudsonWu/linuxStudying/blob/master/bash/my/practical/php_update.sh)
        + [代码更新功能封装](https://github.com/HudsonWu/linuxStudying/blob/master/bash/my/practical/update_git.sh)
+ [expect语言, 自动和交互式任务进行通信](https://github.com/HudsonWu/linuxStudying/tree/master/bash/expect)
+ [shell编程中一些有用的知识点](https://github.com/HudsonWu/linuxStudying/blob/master/bash/usage.md)
+ [判断变量是否为空](https://github.com/HudsonWu/linuxStudying/blob/master/bash/if_null.md)
+ [shell中各种括号的运用](https://github.com/HudsonWu/linuxStudying/blob/master/bash/brackets.md)
+ [set, env, export的区分](https://github.com/HudsonWu/linuxStudying/blob/master/bash/env_vars.md)
+ [一些bash脚本例子](https://github.com/HudsonWu/linuxStudying/tree/master/bash/examples)
+ [linux中的shell](https://github.com/HudsonWu/linuxStudying/blob/master/bash/shell.md)

### [container, A standardized unit of software](https://github.com/HudsonWu/linuxStudying/tree/master/container)

+ [docker, 开源容器解决方案](https://github.com/HudsonWu/linuxStudying/tree/master/container/docker)
    + [Docker是什么](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/start.md)
    + [Docker的常用命令](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/commands.md)
    + [Docker容器的日志查看和清理](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/logs.md)
    + [docker.sock, unix套接字](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/socket.md)
    + [解决实际问题](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/solve.md)
    + [dvwa的docker搭建实例](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/dvwa.md)
    + [Dockerfile文件](https://github.com/HudsonWu/linuxStudying/tree/master/container/docker/Dockerfiles)
        + [Dockerfile介绍](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/Dockerfiles/introduction.md)
        + [CMD和ENTRYPOINT](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/Dockerfiles/entrypoint.md)
        + [多阶段镜像构建](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/Dockerfiles/multi-stage.md)
        + [Dockerfile实例](https://github.com/HudsonWu/linuxStudying/tree/master/container/docker/Dockerfiles/examples)
    + [docker-compose环境搭建](https://github.com/HudsonWu/linuxStudying/tree/master/container/docker/docker-compose)
        + [docker-compose概览](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/docker-compose/overview.md)
        + [docker-compose命令介绍](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/docker-compose/cli.md)
        + [docker-compose.yml配置文件](https://github.com/HudsonWu/linuxStudying/blob/master/container/docker/docker-compose/yml.md)
        + [docker-compose使用实例](https://github.com/HudsonWu/linuxStudying/tree/master/container/docker/docker-compose/examples)
+ [kubernetes, 容器化应用程序的自动部署、扩展和管理](https://github.com/HudsonWu/linuxStudying/tree/master/container/kubernetes)
    + [安装和配置](https://github.com/HudsonWu/linuxStudying/blob/master/container/kubernetes/start.md)
    + [一些概念](https://github.com/HudsonWu/linuxStudying/blob/master/container/kubernetes/concepts.md)
    + [负载均衡](https://github.com/HudsonWu/linuxStudying/blob/master/container/kubernetes/load_balance.md)
    + [kubernetes简单示例](https://github.com/HudsonWu/linuxStudying/tree/master/container/laravel_k8s)
+ [Alpine Linux, 轻型Linux发行版](https://github.com/HudsonWu/linuxStudying/tree/master/container/alpine)

### [进程监控和管理](https://github.com/HudsonWu/linuxStudying/tree/master/process)

+ [ps, 进程查看器](https://github.com/HudsonWu/linuxStudying/blob/master/process/ps.md)
+ [pstree, 以树状图显示进程间关系](https://github.com/HudsonWu/linuxStudying/blob/master/process/pstree.md)
+ [lsof, list open files](https://github.com/HudsonWu/linuxStudying/blob/master/process/lsof.md)
+ [top, linux下的任务管理器](https://github.com/HudsonWu/linuxStudying/blob/master/process/top.md)
+ [类top进程监控工具](https://github.com/HudsonWu/linuxStudying/blob/master/process/top-like.md)
+ [kill, 终止进程](https://github.com/HudsonWu/linuxStudying/blob/master/process/kill.md)
+ [fg, bg, jobs](https://github.com/HudsonWu/linuxStudying/blob/master//process/jobs.md)
+ [IPC, 进程间通信](https://github.com/HudsonWu/linuxStudying/blob/master/process/ipc.md)
+ [supervisor, 进程管理工具](https://github.com/HudsonWu/linuxStudying/tree/master/process/supervisor)

### [linux系统下的文件管理](https://github.com/HudsonWu/linuxStudying/tree/master/file)

+ [file system, 文件系统](https://github.com/HudsonWu/linuxStudying/tree/master/file/fs)
+ [误删除文件恢复](https://github.com/HudsonWu/linuxStudying/tree/master/file/delete_mistake)
+ [tee, 读取标准输入, 输出到标准输出和文件](https://github.com/HudsonWu/linuxStudying/blob/master/file/tee.md)
+ [大文件分卷压缩](https://github.com/HudsonWu/linuxStudying/blob/master/file/sub_volume.md)
+ [reflink, copy on write](https://github.com/HudsonWu/linuxStudying/blob/master/file/reflink.md)
+ [fallocate, 预分配或重新分配空间给文件](https://github.com/HudsonWu/linuxStudying/blob/master/file/fallocate.md)
+ [find, locate, whereis, which](https://github.com/HudsonWu/linuxStudying/blob/master/file/file_search/commands.md)
+ [find命令的深入学习](https://github.com/HudsonWu/linuxStudying/blob/master/file/file_search/find.md)
+ [grep, 强大的文本搜索工具](https://github.com/HudsonWu/linuxStudying/blob/master/file/grep.md)
+ [sed, 流编辑器](https://github.com/HudsonWu/linuxStudying/blob/master/file/sed.md)
+ [awk, 文本文件处理语言](https://github.com/HudsonWu/linuxStudying/blob/master/file/awk.md)
+ [touch命令](https://github.com/HudsonWu/linuxStudying/blob/master/file/touch.md)
+ [文件时间戳的修改](https://github.com/HudsonWu/linuxStudying/blob/master/file/timestamps.md)
+ [rename, 批量重命名](https://github.com/HudsonWu/linuxStudying/blob/master/file/rename.md)
+ [dos2unix和unix2dos, 文本格式转换](https://github.com/HudsonWu/linuxStudying/blob/master/file/dos2unix.md)

### [web技术](https://github.com/HudsonWu/linuxStudying/tree/master/web)

+ [web服务器](https://github.com/HudsonWu/linuxStudying/tree/master/web/web_server)
    + [Nginx, 高性能的HTTP和反向代理服务](https://github.com/HudsonWu/linuxStudying/tree/master/web/web_server/nginx)
        + [nginx简单介绍](https://github.com/HudsonWu/linuxStudying/blob/master/web/web_server/nginx/overview.md)
        + [访问加速的相关配置](https://github.com/HudsonWu/linuxStudying/blob/master/web/web_server/nginx/speed.md)
        + [fastcgi模块主要指令](https://github.com/HudsonWu/linuxStudying/blob/master/web/web_server/nginx/fastcgi_directives.md)
        + [理解Nginx配置文件里指令的继承关系](https://github.com/HudsonWu/linuxStudying/blob/master/web/web_server/nginx/inheritance.md)
        + [配置url重写](https://github.com/HudsonWu/linuxStudying/blob/master/web/web_server/nginx/rewrite.md)
        + [nginx配置文件实例](https://github.com/HudsonWu/linuxStudying/tree/master/web/web_server/nginx/conf_examples)
    + [Caddy, The HTTP/2 Web Server with Automatic HTTPS](https://github.com/HudsonWu/linuxStudying/tree/master/web/web_server/caddy)
+ [HTTP命令行客户端](https://github.com/HudsonWu/linuxStudying/tree/master/web/client)
    + [curl, 数据传输工具](https://github.com/HudsonWu/linuxStudying/tree/master/web/client/curl)
        + [基本用法](https://github.com/HudsonWu/linuxStudying/tree/master/web/client/curl/basic.md)
        + [实用技巧](https://github.com/HudsonWu/linuxStudying/tree/master/web/client/curl/tricks.md)
    + [httpie, http命令行客户端](https://github.com/HudsonWu/linuxStudying/blob/master/web/client/httpie.md)
    + [urlencode编码与解码](https://github.com/HudsonWu/linuxStudying/blob/master/web/client/urlencode.md)
+ [web缓存, HTTP代理, 代理服务器](https://github.com/HudsonWu/linuxStudying/tree/master/web/caching)

### [基础命令, 开启linux之旅](https://github.com/HudsonWu/linuxStudying/tree/master/common)

+ [一些基础命令](https://github.com/HudsonWu/linuxStudying/blob/master/common/some_commands.md)
+ [用户管理](https://github.com/HudsonWu/linuxStudying/blob/master/common/user_group.md)
+ [计划任务](https://github.com/HudsonWu/linuxStudying/tree/master/common/schedule)
    + [at, 在指定时间执行任务](https://github.com/HudsonWu/linuxStudying/blob/master/common/schedule/at.md)
    + [crontab, 周期性地执行任务](https://github.com/HudsonWu/linuxStudying/blob/master/common/schedule/crontab.md)
+ [服务管理](https://github.com/HudsonWu/linuxStudying/tree/master/common/service)
    + [systemctl命令](https://github.com/HudsonWu/linuxStudying/blob/master/common/service/systemctl.md)
    + [journalctl命令](https://github.com/HudsonWu/linuxStudying/blob/master/common/service/journalctl.md)
    + [给程序设置systemd](https://github.com/HudsonWu/linuxStudying/tree/master/common/service/system)
+ [日志管理](https://github.com/HudsonWu/linuxStudying/tree/master/common/log)
    + [日志系统](https://github.com/HudsonWu/linuxStudying/blob/master/common/log/log.md)
    + [history, 历史命令](https://github.com/HudsonWu/linuxStudying/blob/master/common/log/history.md)
    + [logrotate, 日志轮循](https://github.com/HudsonWu/linuxStudying/blob/master/common/log/logrotate.md)
    + [日志清理](https://github.com/HudsonWu/linuxStudying/tree/master/common/log/clean_logs)
+ [日期、时区、字符](https://github.com/HudsonWu/linuxStudying/tree/master/common/time)
    + [epoch, unix timestamp](https://github.com/HudsonWu/linuxStudying/blob/master/common/time/epoch.md)
    + [time命令](https://github.com/HudsonWu/linuxStudying/blob/master/common/time/time.md)
    + [linux时间](https://github.com/HudsonWu/linuxStudying/blob/master/common/time/time.md)
    + [字符和时区](https://github.com/HudsonWu/linuxStudying/blob/master/common/time/lang_timezone.md)
    + [ntp, 网络时间协议](https://github.com/HudsonWu/linuxStudying/blob/master/common/time/ntp.md)
+ [数学计算](https://github.com/HudsonWu/linuxStudying/tree/master/common/calc)
    + [bc, 任意精度计算语言](https://github.com/HudsonWu/linuxStudying/blob/master/common/calc/bc.md)
    + [expr, 命令行计数器](https://github.com/HudsonWu/linuxStudying/blob/master/common/calc/expr.md)
+ [加密和解密](https://github.com/HudsonWu/linuxStudying/tree/master/common/aboutkeys)
    + [Debian中的软件包密钥](https://github.com/HudsonWu/linuxStudying/blob/master/common/aboutkeys/apt-key.md)
    + [GnuPG加密工具](https://github.com/HudsonWu/linuxStudying/blob/master/common/aboutkeys/gpg.md)
    + [openssl加密工具](https://github.com/HudsonWu/linuxStudying/blob/master/common/aboutkeys/openssl.md)
+ [linux邮件功能](https://github.com/HudsonWu/linuxStudying/tree/master/common/mail)
    + [linux下的邮件配置](https://github.com/HudsonWu/linuxStudying/blob/master/common/schedule/mail/config.md)
    + [mail命令](https://github.com/HudsonWu/linuxStudying/blob/master/common/schedule/mail/mail.md)
    + [postfix](https://github.com/HudsonWu/linuxStudying/blob/master/common/schedule/mail/postfix.md)
+ [ssh和ftp](https://github.com/HudsonWu/linuxStudying/tree/master/common/mail)
    + [ssh协议](https://github.com/HudsonWu/linuxStudying/blob/master/common/ssh_and_ftp/ssh.md)
    + [ftp实际使用](https://github.com/HudsonWu/linuxStudying/blob/master/common/ssh_and_ftp/ftp.md)
    + [scp命令](https://github.com/HudsonWu/linuxStudying/blob/master/common/ssh_and_ftp/scp.md)
    + [ssh配置](https://github.com/HudsonWu/linuxStudying/blob/master/common/ssh_and_ftp/config_ssh.md)

### [其他深入的学习](https://github.com/linuxStudying/tree/master/less-is-more)

+ [关系型数据库, 结构化查询语言](https://github.com/HudsonWu/linuxStudying/tree/master/less-is-more/rdbms)
+ [windows的一些便利用法](https://github.com/HudsonWu/linuxStudying/tree/master/less-is-more/windows)
    + [批处理文件](https://github.com/HudsonWu/linuxStudying/tree/master/less-is-more/windows/bat)

## About

这里展示的, 是我在Linux学习过程中的简要笔记, 对于我的帮助有三, 一是学习过程中能加深印象, 二是能时时回来温习下, 三是让我对linux知识有一个系统性的梳理

### About me

我是一位Linux爱好者, 喜欢在命令行下工作, 因为其便捷、功能强大. 在Linux生态圈遨游的过程中, 总会有各种各样奇妙、高级的思想让我惊叹, 让我兴奋, 让我知道学无止境. Linux的学习就是不断地实践, 然后遇到各种错误, 首先尝试独立去解决问题, 然后再看看其他人是怎样应对的, 在解决问题中熟悉各种概念, 知道解决问题的不同方案, 当你有了一定的积累后, 就能熟练地使用这些掌握到的知识去应对出现的各种情况, 满足各种不同的需求. 初级阶段熟练地使用各种强大的工具, 到一定程度就需要独立开发出更加个性化的工具, 满足特定需求, 学习过程是漫长的, 知识的海洋是无穷的

a linux lover, a dreaming man, 

> Before you can run, you need to be able to walk

