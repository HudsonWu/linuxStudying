# `perf stat`, 分析指定程序的性能概况

For any of the supported events, perf can keep a running count during process execution. 
In counting modes, the occurrences of events are simply aggregated and presented on 
standard output at the end of an application run. 
To generate these statistics, use the stat command of perf. 

With no events specified, `perf stat` collects the common events listed above. 
Some are software events, such as context-switches, 
others are generic hardware events such as cycles. 
After the hash sign, derived metrics may be presented, such as 'IPC' (instructions per cycle).

```console
# perf stat -B dd if=/dev/zero of=/dev/null count=1000000
1000000+0 records in
1000000+0 records out
512000000 bytes (512 MB) copied, 0.989133 s, 518 MB/s

 Performance counter stats for 'dd if=/dev/zero of=/dev/null count=1000000':

        987.770734      task-clock (msec)         #    0.998 CPUs utilized          
                15      context-switches          #    0.015 K/sec                  
                 0      cpu-migrations            #    0.000 K/sec                  
               217      page-faults               #    0.220 K/sec                  
   <not supported>      cycles                                                      
   <not supported>      instructions                                                
   <not supported>      branches                                                    
   <not supported>      branch-misses                                               

       0.990127152 seconds time elapsed

```

输出:
```
task-clock: 任务真正占用的处理器时间, 单位为ms. 
            CPUs utilized = task-clock / time elapsed, CPU的占用率. 
context-switches: 上下文的切换次数. 
CPU-migrations: 处理器迁移次数. Linux为了维持多个处理器的负载均衡, 
                在特定条件下会将某个任务从一个CPU迁移到另一个CPU. 
page-faults: 缺页异常的次数. 当应用程序请求的页面尚未建立、请求的页面不在内存中, 
             或者请求的页面虽然在内存中, 但物理地址和虚拟地址的映射关系尚未建立时, 
             都会触发一次缺页异常. 另外TLB不命中, 页面访问权限不匹配等情况也会触发缺页异常. 
cycles: 消耗的处理器周期数. 如果把被ls使用的cpu cycles看成是一个处理器的, 那么它的主频为2.486GHz. 
        可以用cycles / task-clock算出. 
instructions: 执行了多少条指令. IPC为平均每个cpu cycle执行了多少条指令. 
branches: 遇到的分支指令数. branch-misses是预测错误的分支指令数. 
```

命令行参数:
```
-p: stat events on existing process id (comma separated list). 仅分析目标进程及其创建的线程. 
-a: system-wide collection from all CPUs. 从所有CPU上收集性能数据. 
-r: repeat command and print average + stddev (max: 100). 重复执行命令求平均. 
-C: Count only on the list of CPUs provided (comma separated list), 从指定CPU上收集性能数据. 
-v: be more verbose (show counter open errors, etc), 显示更多性能数据. 
-n: null run - do not start any counters, 只显示任务的执行时间 . 
-x SEP: 指定输出列的分隔符. 
-o file: 指定输出文件, --append指定追加模式. 
--pre <cmd>: 执行目标程序前先执行的程序. 
--post <cmd>: 执行目标程序后再执行的程序. 
```

使用例子:
```
//执行10次程序, 给出标准偏差与期望的比值: 
perf stat -r 10 ls > /dev/null

//显示更详细的信息: 
perf stat -v ls > /dev/null

//只显示任务执行时间, 不显示性能计数器: 
perf stat -n ls > /dev/null

//单独给出每个CPU上的信息: 
perf stat -a -A ls > /dev/null

//ls命令执行了多少次系统调用: 
perf stat -e syscalls:sys_enter ls 
```

## Options controlling event selection

It is possible to measure one or more events per run of the perf tool. 
Events are designated using their symbolic names followed by optional unit masks and modifiers. 
Event names, unit masks, and modifiers are case insensitive.

By default, events are measured at both user and kernel levels:
```sh
perf stat -e cycles dd if=/dev/zero of=/dev/null count=100000
```
To measure only at the user level, it is necessary to pass a modifier:
```sh
perf stat -e cycles:u dd if=/dev/zero of=/dev/null count=100000
```
To measure both user and kernel(explicitly):
```sh
perf stat -e cycles:uk dd if=/dev/zero of=/dev/null count=100000
```

Events can optionally have a modifier by appending a colon and one or more modifiers. 
Modifiers allow the user to restrict when events are counted.

## Modifier

To measure a PMU event and pass modifiers:
```sh
perf stat -e instructions:u dd if=/dev/zero of=/dev/null count=100000
```
In this example, we are measuring the number of instructions at the user level. 
Note that for actual events, the modifiers depends on the underlying PMU model. 
All modifiers can be combined at will. 
Here is a simple table to summarize the most common modifiers for Intel and AMD x86 processors.
```
Modifiers        Description        Example
u    monitor at priv level 3, 2, 1 (user)    event:u
k    monitor at priv level 0 (kernel)    event:k
h    monitor hypervisor events on a virtualization environment    event:h
H    monitor host machine on a virtualization environment    event:H
G    monitor guest machine on a virtualization environment    event:G
```
All modifiers above are considered as a boolean (flag).

## Hardware events

To measure an actual PMU as provided by the HW vendor documentation, 
pass the hexadecimal parameter code:
```console
# perf stat -e r1a8 -a sleep 1

Performance counter stats for 'sleep 1':

            210,140 raw 0x1a8
       1.001213705  seconds time elapsed
```

## multiple events

To measure more than one event, simply provide a comma-separated list with no space:
```sh
perf stat -e cycles,instructions,cache-misses
```
There is no theoretical limit in terms of the number of events that can be provided. 
If there are more events than there are actual hw counters, 
the kernel will automatically multiplex them. 
There is no limit of the number of software events. 
It is possible to simultaneously measure events coming from different sources. 
However, given that there is one file descriptor used per event and either per-thread (per-thread mode) or per-cpu (system-wide), 
it is possible to reach the maximum number of open file descriptor per process as imposed by the kernel. 
