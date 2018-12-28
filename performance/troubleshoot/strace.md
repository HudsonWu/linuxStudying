# strace, 跟踪进程中的系统调用

strace命令是一个集诊断、调试、统计于一体的工具, 我们可以使用strace对应用的系统调用和信号传递的跟踪结果来对应用进行分析, 以达到解决问题或者是了解应用工作过程的目的

strace的最简单用法就是执行一个指定的命令, 在指定的命令结束之后它也就退出了, 在命令执行过程中, strace会记录和解析命令进程的所有系统调用以及这个进程所接收到的所有的信号值


## References

+ <https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/strace.html>
+ <http://man.linuxde.net/strace>

