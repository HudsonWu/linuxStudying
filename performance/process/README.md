# 进程管理

## 进程状态

linux上进程有5种状态: <br/>
1. 运行, 正在运行或在运行队列中等待
2. 中断, 休眠中, 受阻, 在等待某个条件的形成或接收到信号
3. 不可中断, 收到信号不唤醒和不可运行, 进程必须等待直到有中断发生
4. 僵死, 进程已终止, 但进程描述符存在, 直到父进程调用wait4()系统调用后释放
5. 停止, 进程收到SIGSTOP, SIGTSTP, SIGTTIN, SIGTTOU信号后停止运行


+ [ps, 进程查看器](/performance/process/ps.md)
+ [pstree, 以树状图显示进程间关系](/performance/process/pstree.md)
+ [lsof, list open files](/performance/process/lsof.md)
+ [pidstat, report statistics for tasks](/performance/process/pidstat.md)
+ [uptime, 查看系统平均负载](/performance/process/uptime.md)
+ [kill, 终止进程](/performance/process/kill.md)
+ [fg, bg, jobs](//performance/process/jobs.md)
+ [IPC, 进程间通信](/performance/process/ipc.md)
+ [proc文件系统, 访问系统内核信息的接口](/performance/process/procfs.md)
+ [supervisor, 进程管理工具](https://github.com/HudsonWu/linuxStudying/tree/master/performance/process/supervisor)

