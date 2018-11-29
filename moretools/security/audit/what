用户空间审计工具audit

1. linux用户空间审计系统由auditd, audispd, audictl, autrace, ausearch和aureport等应用组成

+ audictl
即时控制审计守护进程的行为, 如添加规则等

+ auditd
守护进程, 负责把内核产生的信息写入到硬盘(/var/log/audit/audit.log)上, 这些信息由应用和系统活动触发产生

+ aureport
查看和生成审计报告

+ ausearch
查找审计事件

+ audispd
转发事件通知给其他应用

+ autrace
跟踪进程, 并将跟踪结果写入到日志文件

+ /etc/audit/audit.rules
记录审计规则的文件, 确定audit的日志记录哪些操作, 它通过一个对audit进行控制的应用auditctl进行操作

+ /etc/audit/auditd.conf
auditd工具的默认配置文件, 是linux安全审计系统最关键文件
确定auditd是如何启动的, 日志文件放在哪里等
一般先设置日志文件, 然后设置是否循环使用日志文件, 配置日志文件大小和报警信息, 设置审计规则信息和目录观察器
> log_file = /var/log/audit/audit.log
> num_logs = 5  //设置日志文件轮循数目, 在0-99之间, 如果小于2, 则不会循环日志
> //如果没有设置num_logs值, 默认为0, 意味着从不循环日志文件
> num_format = NONE  //设置是否使用主机名称, 一般为NONE
> max_log_file = 6  //设置日志文件大小, 以兆字节表示, 当达到时, 执行max_log_file_action指定动作
> max_log_file_action = ROTATE  //轮循

2. linux内核中的几种系统调用

audit是内核中的一个模块, 内核的运行情况都会在audit中记录, 内核的audit模块由应用层的一个程序auditd控制
audit产生的数据都会传递到auditd中, 由auditd进行其它操作

+ User
记录用户空间中产生的事件, 作用是过滤消息, 内核传递给审计后台进程之前先查询它

+ Task
跟踪应用程序的子进程(fork), 当一个任务被创建时, 也就是父进程通过fork和克隆创建子进程时记录该事件

+ Exit
当一个系统调用结束时判断是否记录该调用

+ Exclude
删除不合格事件, 用来过滤消息, 不想看到的消息可以在这里写规则进行过滤

3. audit和syslog的关系
audit主要用来记录安全信息, 用于对系统安全事件的追溯
syslog日志系统用来记录系统中的各种信息, 如硬件警报和软件日志等
syslog属于应用层, 没办法记录太多信息
audit来记录内核信息, 包括文件的读写, 权限的改变等

https://www.ibm.com/developerworks/cn/linux/l-lo-use-space-audit-tool/index.html
