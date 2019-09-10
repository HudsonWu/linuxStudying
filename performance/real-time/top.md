# top, Linux Process Monitoring

The linux top command is used to show all the running processes within your linux environment <br/>

top命令是linux下常用的性能分析工具, 能够实时显示系统中各个进程的资源占用状况 <br/>

```
# 查看指定进程的线程资源占用状况
top -H -p 15303
```


## What information is shown

+ line 1
    + the time, how long the computer has been running
    + number of users
    + load average
+ line 2 (tasks)
    + total number of tasks
    + number of running tasks
    + number of sleeping tasks
    + number of stopped tasks
    + number of zombie tasks
+ line 3 (cpu usage as a percentage, cpu时间占用百分比)
    + us, user, 用户态进程, 不包含renice值为负的任务
    + sy, system, 内核
    + ni, nice, 改变过优先级的进程
    + id, idle processes, 空闲
    + wa, io wait, 等待I/O的CPU时间百分比
    + hi, hardware interrupts, CPU硬中断时间百分比
    + si, software interrupts, CPU软终端时间百分比
    + st, steal time
+ line 4 (Memory)
    + total, 物理内存总量
    + used, 使用的物理内存量
    + free, 空闲的物理内存量
    + buff/cache, 用做内核缓存的物理内存量
+ line 5 (Swap, 交换空间)
    + total, 交换区总量
    + used, 使用的交换区量
    + free, 空闲的交换区量
    + cached, 缓冲交换区总量
+ Main Table (进程信息)
    + PID, 进程ID
    + USER, 进程所有者
    + PR, priority, 进程优先级别, 越小越优先被执行
    + NI, nice level
    + VIRT, virtual memory used by process, 进程占用的虚拟内存
    + RES, resident memory used by a process, 进程占用的物理内存
    + SHR, shareable memory, 进程占用的共享内存
    + %CPU, cpu used by process as a percentage
    + S, 进程的状态, S 休眠, R 正在运行, Z 僵死, N 进程优先值为负数
    + %MEM, memory used by process as a percentage
    + TIME+, 该进程启动后占用的总CPU时间
    + COMMAND, 进程启动命令名称

## Key switches for the top command

```
选项:
-c,  this toggles the command column between showing command and program name(*)
-d,  specify the delay time between refreshing the screen
-O,  to get a list of the columns
-o,  sorts by a column name
-p,  only show processes with specified process IDs
-u,  show only processes by the specified user
-i,  do not show idle tasks

命令交互指令:
<space>, 立即刷新
s, 设置刷新时间间隔
c, 显示命令完全模式
t, 显示或隐藏进程和CPU状态信息
m, 显示或隐藏内存状态信息
l, 显示或隐藏uptime信息
f, 增加或减少进程显示标志
S, 累计模式, 会把已完成或退出的子进程占用的CPU时间累计到父进程的TIME+
P, 按%CPU使用率排行
T, 按TIME+排行
M, 按%MEM排行
u, 指定显示用户进程
r, 修改进程renice值
k, kill进程
b, 高亮当前运行进程
i, 只显示正在运行的进程
z, 切换彩色或黑白模式
A, 根据各种系统资源的利用率进行排序, 有助于快速识别系统中性能不佳的任务
W, 保存对top的设置到文件~/.toprc, 下次启动将自动调用
通过 "shift + >" 或 "shift + <"可以向右或向左改变排序列
按数字键1, 可监控每个逻辑CPU的状况
```
