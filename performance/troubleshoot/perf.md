# perf, Linux profiling with performance counters

`perf`是Linux下的一款性能分析工具, 能够进行函数级与指令级的热点查找

`perf`, also called `perf_events`. It can instrument CPU performance counters, tracepoints, kprobes, and uprobes(dynamic tracing). It is capable of lightweight profiling. It is also included in the Linux kernel, under tools/perf, and is frequently updated and enhanced.

`perf` is a profiler tool for Linux 2.6+ based systems that abstracts away CPU hardware differences in Linux performance measurements and presents a simple commandline interface. `perf` is based on the `perf_events` interface exported by recent versions of the Linux kernel.

`perf`是内置于Linux内核源码树中的性能剖析(profiling)工具, 它基于事件采样原理, 以性能事件为基础, 支持针对处理器相关性能指标与操作系统相关性能指标的性能剖析, 常用于性能瓶颈的查找与热点代码的定位

The userspace `perf` command present a simple to use interface with commands like:
+ `perf stat`, obtain event counts
+ `perf record`, record events for later reporting
+ `perf annotate`, annotate assembly or source code with event counts
+ `perf top`, see live event count
+ `perf bench`, run different kernel microbenchmarks

The perf tool offers a rich set of commands to collect and analyze performance and trace data.

```
 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

 The most commonly used perf commands are:
   annotate        Read perf.data (created by perf record) and display annotated code
   archive         Create archive with object files with build-ids found in perf.data file
   bench           General framework for benchmark suites
   buildid-cache   Manage build-id cache.
   buildid-list    List the buildids in a perf.data file
   c2c             Shared Data C2C/HITM Analyzer.
   config          Get and set variables in a configuration file.
   data            Data file related processing
   diff            Read perf.data files and display the differential profile
   evlist          List the event names in a perf.data file
   ftrace          simple wrapper for kernel's ftrace functionality
   inject          Filter to augment the events stream with additional information
   kallsyms        Searches running kernel for symbols
   kmem            Tool to trace/measure kernel memory properties
   kvm             Tool to trace/measure kvm guest os
   list            List all symbolic event types
   lock            Analyze lock events
   mem             Profile memory accesses
   record          Run a command and record its profile into perf.data
   report          Read perf.data (created by perf record) and display the profile
   sched           Tool to trace/measure scheduler properties (latencies)
   script          Read perf.data (created by perf record) and display trace output
   stat            Run a command and gather performance counter statistics
   test            Runs sanity tests.
   timechart       Tool to visualize total system behavior during a workload
   top             System profiling tool.
   probe           Define new dynamic tracepoints
   trace           strace inspired tool

 See 'perf help COMMAND' for more information on a specific command.
```

## Events

The perf tool supports a list of measurable events. The tool and underlying kernel interface can measure events coming from different sources. For instance, some event are pure kernel counters, in this case they are called `software events`. Examples include: context-switches, minor-faults.

Another source of events is the processor itself and its Performance Monitoring Unit (PMU). It provides a list of events to measure micro-architectural events such as the number of cycles, instructions retired, L1 cache misses and so on. Those events are called PMU hardware events or hardware events for short. They vary with each processor type and model.

The `perf_events` interface also provides a small set of common hardware events monikers. On each processor, those events get mapped onto an actual events provided by the CPU, if they exists, otherwise the event cannot be used. Somewhat confusingly, these are also called hardware events and hardware cache events.

Finally, there are also tracepoint events which are implemented by the kernel ftrace infrastructure. Those are only available with the 2.6.3x and newer kernels.

CPU周期(cpu-cycles)是默认的性能事件, 所谓的CPU周期是指CPU所能识别的最小时间单元, 通常为亿分之几秒, 是CPU执行最简单的指令所需要的时间, 例如读取寄存器的内容, 也叫做`clock tick`

性能事件的分布:
```
hw: Hardware event, 9个
sw: Software event, 9个
cache: Hardware cache event, 26个
tracepoint: Tracepoint event, 775个
```
sw实际上是内核的计数器, 与硬件无关; hw和cache是CPU架构相关的, 依赖于具体硬件; tracepoint是基于内核的ftrace, 主线2.6.3x以上的内核版本才支持

### `perf list`, 查看支持的性能事件

To obtain a list of supported events: `perf list`

`perf list`用来查看perf所支持的性能事件, 有软件的也有硬件的

An event can have sub-events (or unit masks). On some processors and for some events, it may be possible to combine unit masks and measure when either sub-event occurs. Finally, an event can have modifiers, i.e., filters which alter when or how the event is counted.

`Hardware events`: PMU hardware events are CPU specific and documented by the CPU vendor. The perf tool, if linked against the libpfm4 library, provides some short description of the events. For a listing of PMU hardware events for Intel and AMD processors, see
+ Intel PMU event tables: Appendix A of manual [here](http://www.intel.com/Assets/PDF/manual/253669.pdf)
+ AMD PMU event table: section 3.14 of manual [here](http://support.amd.com/us/Processor_TechDocs/31116.pdf)

## `perf stat`, 分析指定程序的性能概况

For any of the supported events, perf can keep a running count during process execution. In counting modes, the occurrences of events are simply aggregated and presented on standard output at the end of an application run. To generate these statistics, use the stat command of perf. For instance:

With no events specified, `perf stat` collects the common events listed above. Some are software events, such as context-switches, others are generic hardware events such as cycles. After the hash sign, derived metrics may be presented, such as 'IPC' (instructions per cycle).
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
-n: null run - don't start any counters, 只显示任务的执行时间 . 
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

### Options controlling event selection

It is possible to measure one or more events per run of the perf tool. Events are designated using their symbolic names followed by optional unit masks and modifiers. Event names, unit masks, and modifiers are case insensitive.

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

Events can optionally have a modifier by appending a colon and one or more modifiers. Modifiers allow the user to restrict when events are counted.

### Modifier

To measure a PMU event and pass modifiers:
```sh
perf stat -e instructions:u dd if=/dev/zero of=/dev/null count=100000
```
In this example, we are measuring the number of instructions at the user level. Note that for actual events, the modifiers depends on the underlying PMU model. All modifiers can be combined at will. Here is a simple table to summarize the most common modifiers for Intel and AMD x86 processors.
```
Modifiers        Description        Example
u    monitor at priv level 3, 2, 1 (user)    event:u
k    monitor at priv level 0 (kernel)    event:k
h    monitor hypervisor events on a virtualization environment    event:h
H    monitor host machine on a virtualization environment    event:H
G    monitor guest machine on a virtualization environment    event:G
```
All modifiers above are considered as a boolean (flag).

### Hardware events

To measure an actual PMU as provided by the HW vendor documentation, pass the hexadecimal parameter code:
```console
# perf stat -e r1a8 -a sleep 1

Performance counter stats for 'sleep 1':

            210,140 raw 0x1a8
       1.001213705  seconds time elapsed
```

### multiple events

To measure more than one event, simply provide a comma-separated list with no space:
```sh
perf stat -e cycles,instructions,cache-misses
```
There is no theoretical limit in terms of the number of events that can be provided. If there are more events than there are actual hw counters, the kernel will automatically multiplex them. There is no limit of the number of software events. It is possible to simultaneously measure events coming from different sources. However, given that there is one file descriptor used per event and either per-thread (per-thread mode) or per-cpu (system-wide), it is possible to reach the maximum number of open file descriptor per process as imposed by the kernel. 

## `perf top`

对于一个指定的性能事件(默认是CPU周期), 显示消耗最多的函数或指令

`perf top`主要用于实时分析各个函数在某个性能事件上的热度, 能够快速定位热点函数, 包括应用程序函数, 模块函数与内核函数, 甚至能够定位到热点指令, 默认的性能事件为`cpu cycles`

```console
# perf top
Samples: 8K of event 'cpu-clock', Event count (approx.): 222032802                                                             
Overhead  Shared Object                    Symbol                                                                              
  10.87%  [kernel]                         [k] _raw_spin_unlock_irqrestore
  10.36%  [kernel]                         [k] finish_task_switch
   7.09%  [kernel]                         [k] __do_softirq
   6.34%  [kernel]                         [k] tick_nohz_idle_enter
   2.70%  node                             [.] poll_cb
   2.58%  node                             [.] uv_timer_stop
   2.50%  [kernel]                         [k] __d_lookup_rcu
   1.75%  [kernel]                         [k] system_call_after_swapgs
   1.26%  libc-2.17.so                     [.] __select
   1.19%  libc-2.17.so                     [.] free
```

输出:
```
第一列: 符号引发的性能事件的比例, 默认指占用的cpu周期比例. 
第二列: 符号所在的DSO(Dynamic Shared Object), 可以是应用程序、内核、动态链接库、模块. 
第三列: DSO的类型, [.]表示此符号属于用户态的ELF文件, 包括可执行文件与动态链接库); [k]表述此符号属于内核或模块. 
第四列: 符号名, 有些符号不能解析为函数名, 只能用地址表示. 
```

常用交互命令:
```
h, 显示帮助
UP/DOWN/PGUP/PGDN/SPACE, 上下和翻页
a, annotate current symbol, 注解当前符号, 能够给出汇编语言的注解, 给出各条指令的采样率
d, 过滤掉所有不属于此DSO的符号, 非常方便查看同一类别的符号
P, 将当前信息保存到perf.hist.N中
```

常用命令行参数:
```
-e <event>: 指明要分析的性能事件. 
-p <pid>: Profile events on existing Process ID (comma sperated list). 仅分析目标进程及其创建的线程. 
-k <path>: Path to vmlinux. Required for annotation functionality. 带符号表的内核映像所在的路径. 
-K: 不显示属于内核或模块的符号. 
-U: 不显示属于用户态程序的符号. 
-d <n>: 界面的刷新周期, 默认为2s, 因为perf top默认每2s从mmap的内存区域读取一次性能数据. 
-G: 得到函数的调用关系图. 
perf top -G [fractal], 路径概率为相对值, 加起来为100%, 调用顺序为从下往上. 
perf top -G graph, 路径概率为绝对值, 加起来为该函数的热度
```

例子:
```
perf top  // 默认配置
perf top -G  // 得到调用关系图
perf top -e cycles  // 指定性能事件
perf top -p 23015,32476  // 查看这两个进程的cpu cycles使用情况
perf top -s comm,pid,symbol  // 显示调用symbol的进程名和进程号
perf top --comms nginx,top  // 仅显示属于指定进程的符号
perf top --symbols kfree  // 仅显示指定的符号
```

## `perf-record`, 收集采样信息

Run a command and record its profile into perf.data.

This command runs a command and gathers a performance counter profile from it, into perf.data,

without displaying anything. This file can then be inspected later on, using perf report.

收集采样信息, 并将其记录在数据文件中. 随后可以通过其它工具(perf-report)对数据文件进行分析
 

常用参数:
```
-e: Select the PMU event.
-a: System-wide collection from all CPUs.
-p: Record events on existing process ID (comma separated list).
-A: Append to the output file to do incremental profiling.
-f: Overwrite existing data file.
-o: Output file name.
-g: Do call-graph (stack chain/backtrace) recording.
-C: Collect samples only on the list of CPUs provided.
```
 
使用例子:
```
//记录nginx进程的性能数据
perf record -p `pgrep -d ',' nginx`

//记录执行ls时的性能数据
perf record ls -g

//记录执行ls时的系统调用, 可以知道哪些系统调用最频繁: 
perf record -e syscalls:sys_enter ls

perf record -e cycles -g -p <my_pid>
```
 
## `perf-report`
 
读取perf record创建的数据文件, 并给出热点分析结果. 
 
Read perf.data (created by perf record) and display the profile.
This command displays the performance counter profile information recorded via perf record.
 
常用参数:
```
-i: Input file name. (default: perf.data)
```

使用例子:
```
perf report -i perf.data.2
```

## More
 
除了以上常用工具外, 还有一些适用于较特殊场景的工具,  比如内核锁、slab分配器、调度器, 也支持自定义探测点. 
 
### `perf-lock`, 内核锁的性能分析

Analyze lock events.

```
perf lock {record | report | script | info}
 
需要编译选项的支持: CONFIG_LOCKDEP、CONFIG_LOCK_STAT. 
CONFIG_LOCKDEP defines acquired and release events.
CONFIG_LOCK_STAT defines contended and acquired lock events.

常用选项:
-i <file>: 输入文件
-k <value>: sorting key, 默认为acquired, 还可以按contended、wait_total、wait_max和wait_min来排序. 
 
使用例子:
perf lock record ls  // 记录
perf lock report  // 报告
 
输出格式:
                Name   acquired  contended total wait (ns)   max wait (ns)   min wait (ns) 
 &mm->page_table_...        382          0               0               0               0 
 &mm->page_table_...         72          0               0               0               0 
           &fs->lock         64          0               0               0               0 
         dcache_lock         62          0               0               0               0 
       vfsmount_lock         43          0               0               0               0 
 &newf->file_lock...         41          0               0               0               0 
 
Name: 内核锁的名字. 
aquired: 该锁被直接获得的次数, 因为没有其它内核路径占用该锁, 此时不用等待. 
contended: 该锁等待后获得的次数, 此时被其它内核路径占用, 需要等待. 
total wait: 为了获得该锁, 总共的等待时间. 
max wait: 为了获得该锁, 最大的等待时间. 
min wait: 为了获得该锁, 最小的等待时间. 
最后还有一个Summary: 
=== output for debug===
bad: 10, total: 246
bad rate: 4.065041 %
histogram of events caused bad sequence
    acquire: 0
   acquired: 0
  contended: 0
    release: 10
```
 
### `perf-kmem`, slab分配器的性能分析 

Tool to trace/measure kernel memory(slab) properties.

```
perf kmem {record | stat} [<options>]

常用选项:
--i <file>: 输入文件
--caller: show per-callsite statistics, 显示内核中调用kmalloc和kfree的地方. 
--alloc: show per-allocation statistics, 显示分配的内存地址. 
-l <num>: print n lines only, 只显示num行. 
-s <key[,key2...]>: sort the output (default: frag,hit,bytes)

使用例子:
perf kmem record ls  // 记录
perf kmem stat --caller --alloc -l 20  // 报告

输出格式:
------------------------------------------------------------------------------------------------------
 Callsite                           | Total_alloc/Per | Total_req/Per   | Hit      | Ping-pong | Frag
------------------------------------------------------------------------------------------------------
 perf_event_mmap+ec                 |    311296/8192  |    155952/4104  |       38 |        0 | 49.902%
 proc_reg_open+41                   |        64/64    |        40/40    |        1 |        0 | 37.500%
 __kmalloc_node+4d                  |      1024/1024  |       664/664   |        1 |        0 | 35.156%
 ext3_readdir+5bd                   |        64/64    |        48/48    |        1 |        0 | 25.000%
 load_elf_binary+8ec                |       512/512   |       392/392   |        1 |        0 | 23.438%
Callsite: 内核代码中调用kmalloc和kfree的地方. 
Total_alloc/Per: 总共分配的内存大小, 平均每次分配的内存大小. 
Total_req/Per: 总共请求的内存大小, 平均每次请求的内存大小. 
Hit: 调用的次数. 
Ping-pong: kmalloc和kfree不被同一个CPU执行时的次数, 这会导致cache效率降低. 
Frag: 碎片所占的百分比, 碎片 = 分配的内存 - 请求的内存, 这部分是浪费的. 
有使用--alloc选项, 还会看到Alloc Ptr, 即所分配内存的地址. 
最后还有一个Summary: 
SUMMARY
=======
Total bytes requested: 290544
Total bytes allocated: 447016
Total bytes wasted on internal fragmentation: 156472
Internal fragmentation: 35.003669%
Cross CPU allocations: 2/509
```
 
### `probe-sched`, 调度模块分析

trace/measure scheduler properties (latencies)

```
perf sched {record | latency | map | replay | script}
 
使用例子: 
perf sched record sleep 10 // perf sched record <command>
perf report latency --sort max
 
输出格式:
 ---------------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at     |
 ---------------------------------------------------------------------------------------------------------------
  events/10:61          |      0.655 ms |       10 | avg:    0.045 ms | max:    0.161 ms | max at: 9804.958730 s
  sleep:11156           |      2.263 ms |        4 | avg:    0.052 ms | max:    0.118 ms | max at: 9804.865552 s
  edac-poller:1125      |      0.598 ms |       10 | avg:    0.042 ms | max:    0.113 ms | max at: 9804.958698 s
  events/2:53           |      0.676 ms |       10 | avg:    0.037 ms | max:    0.102 ms | max at: 9814.751605 s
  perf:11155            |      2.109 ms |        1 | avg:    0.068 ms | max:    0.068 ms | max at: 9814.867918 s
TASK: 进程名和pid. 
Runtime: 实际的运行时间. 
Switches: 进程切换的次数. 
Average delay: 平均的调度延迟. 
Maximum delay: 最大的调度延迟. 
Maximum delay at: 最大调度延迟发生的时刻. 
```

### `perf-probe`, 可以自定义探测点 

Define new dynamic tracepoints.

``` 
使用例子:
1. Display which lines in schedule() can be probed
perf probe --line schedule
//前面有行号的可以探测, 没有行号的就不行了. 
 
2. Add a probe on schedule() function 12th line.
perf probe -a schedule:12
//在schedule函数的12处增加一个探测点. 
```

## References

+ <https://perf.wiki.kernel.org/index.php/Tutorial>
