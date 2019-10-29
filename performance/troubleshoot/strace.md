# strace, 跟踪进程中的系统调用

```
# 查看系统调用
strace -p 202

# 按调用时间汇总
# 找出耗CPU的操作
strace -cp 202

# 单独跟踪write的调用情况
strace -p 202 -Te write

# 过滤write操作
strace -Tf -p 202 2>&1 | grep -v write

# 跟踪多个pid
strace -f $(pidof php-fpm | sed 's/\([0-9]*\)/\-p \1/g')
```

strace命令是一个集诊断、调试、统计于一体的工具, 
我们可以使用strace对应用的系统调用和信号传递的跟踪结果来对应用进行分析, 
以达到解决问题或者是了解应用工作过程的目的

strace的最简单用法就是执行一个指定的命令, 
在指定的命令结束之后它也就退出了, 
在命令执行过程中, strace会记录和解析命令进程的所有系统调用
以及这个进程所接收到的所有的信号值

strace常用来跟踪进程执行的系统调用和所接收的信号, 
strace可以跟踪一个进程产生的系统调用, 包括参数、返回值, 执行消耗时间

```
# 系统调用报告
## -c, 统计每一系统调用的所执行时间, 次数和出错的次数等
strace -c ifconfig eth0

# 跟踪指定的系统调用
## -e open等价于-e trace=open
strace -e open ifconfig eth0
## 跟踪多个系统调用
strace -e trace=mprotect,brk ifconfig eth0

# 跟踪可执行程序
## -f, 跟踪由fork调用所产生的子进程
## -F, 尝试跟踪vfork调用
## myserver是要启动和调试的程序
strace -f -F -o /path/straceout.txt myserver

# 跟踪服务程序
## -T, 显示每一调用所耗的时间
## -tt, 在输出中的每一行前加上时间信息, 毫秒级
## -e trace=all, 表示跟踪进程的所有系统调用
strace -o output.txt -T -tt -e trace=all -p 28792
```

```
-e trace=set, 只跟踪指定的系统调用, 默认的为set=all
如-e trace=open,close,rean,write表示只跟踪这四个系统调用

-e trace=file, 只跟踪有关文件操作的系统调用
-e trace=process, 只跟踪有关进程控制的系统调用
-e trace=network, 跟踪与网络有关的所有系统调用
-e trace=signal, 跟踪所有与系统信号有关的系统调用
-e trace=ipc, 跟踪所有与进程通讯有关的系统调用
```

## References

+ <https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/strace.html>
+ <http://man.linuxde.net/strace>

