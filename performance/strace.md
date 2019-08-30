# strace, 跟踪进程中的系统调用

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
