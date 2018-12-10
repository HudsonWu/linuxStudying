# 进程管理

## 进程状态

linux上进程有5种状态: <br/>
1. 运行, 正在运行或在运行队列中等待
2. 中断, 休眠中, 受阻, 在等待某个条件的形成或接收到信号
3. 不可中断, 收到信号不唤醒和不可运行, 进程必须等待直到有中断发生
4. 僵死, 进程已终止, 但进程描述符存在, 直到父进程调用wait4()系统调用后释放
5. 停止, 进程收到SIGSTOP, SIGTSTP, SIGTTIN, SIGTTOU信号后停止运行


+ [ps, 进程查看器](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/ps.md)
+ [pstree, 以树状图显示进程间关系](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/pstree.md)
+ [top, linux下的任务管理器](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/top.md)
+ [类top进程监控工具](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/top-like.md)
+ [kill, 终止进程](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/kill.md)
+ [fg, bf, jobs](https://github.com/HudsonWu/linuxStudying/blob/master/performance//process/jobs.md)
+ [supervisor, 进程管理工具](https://github.com/HudsonWu/linuxStudying/tree/master/performance/process/supervisor)