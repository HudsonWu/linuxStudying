# More
 
除了以上常用工具外, 还有一些适用于较特殊场景的工具,  
比如内核锁、slab分配器、调度器, 也支持自定义探测点. 
 
## `perf-lock`, 内核锁的性能分析

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
 
## `perf-kmem`, slab分配器的性能分析 

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
 
## `probe-sched`, 调度模块分析

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

## `perf-probe`, 可以自定义探测点 

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

