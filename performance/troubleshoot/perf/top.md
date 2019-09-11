# perf top

对于一个指定的性能事件(默认是CPU周期), 
显示消耗最多的函数或指令

`perf top`主要用于实时分析各个函数在某个性能事件上的热度, 
能够快速定位热点函数, 包括应用程序函数, 模块函数与内核函数, 
甚至能够定位到热点指令, 默认的性能事件为`cpu cycles`

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
第一列: 
  符号引发的性能事件的比例, 默认指占用的cpu周期比例 
第二列: 
  符号所在的DSO(Dynamic Shared Object), 
  可以是应用程序、内核、动态链接库、模块
第三列: 
  DSO的类型, 
  [.]表示此符号属于用户态的ELF文件, 包括可执行文件与动态链接库; 
  [k]表述此符号属于内核或模块
第四列: 
  符号名, 有些符号不能解析为函数名, 只能用地址表示
```

常用交互命令:
```
h, 显示帮助
UP/DOWN/PGUP/PGDN/SPACE, 上下和翻页
a, annotate current symbol, 注解当前符号, 
   能够给出汇编语言的注解, 给出各条指令的采样率
d, 过滤掉所有不属于此DSO的符号, 非常方便查看同一类别的符号
P, 将当前信息保存到perf.hist.N中
```

常用命令行参数:
```
-e <event>: 指明要分析的性能事件. 
-p <pid>: Profile events on existing Process ID (comma sperated list), 
          仅分析目标进程及其创建的线程
-k <path>: Path to vmlinux. Required for annotation functionality, 
          带符号表的内核映像所在的路径. 
-K: 不显示属于内核或模块的符号. 
-U: 不显示属于用户态程序的符号. 
-d <n>: 界面的刷新周期, 默认为2s, 
        因为perf top默认每2s从mmap的内存区域读取一次性能数据. 
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

