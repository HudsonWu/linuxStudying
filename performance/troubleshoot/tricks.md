# 经常使用的命令

```
# 查看进程的多线程
top -H -p 34422
ps -eLf
ps -eo ruser,pid,ppid,lwp,psr,args -L

# 定位线程堆栈
pstack 34422
strace -f -p 34422
strace -f -F -T -tt -p 34422
```
