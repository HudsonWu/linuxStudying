# perf, Linux profiling with performance counters

`perf`是Linux下的一款性能分析工具, 能够进行函数级与指令级的热点查找

`perf`, also called `perf_events`. 
It can instrument CPU performance counters, tracepoints, kprobes, and uprobes(dynamic tracing). 
It is capable of lightweight profiling. 
It is also included in the Linux kernel, under tools/perf, and is frequently updated and enhanced.

`perf` is a profiler tool for Linux 2.6+ based systems that abstracts away CPU hardware differences 
in Linux performance measurements and presents a simple commandline interface. 
`perf` is based on the `perf_events` interface exported by recent versions of the Linux kernel.

`perf`是内置于Linux内核源码树中的性能剖析(profiling)工具, 
它基于事件采样原理, 以性能事件为基础, 
支持针对处理器相关性能指标与操作系统相关性能指标的性能剖析, 
常用于性能瓶颈的查找与热点代码的定位

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
   ftrace          simple wrapper for kernel ftrace functionality
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

The perf tool supports a list of measurable events. 
The tool and underlying kernel interface can measure events coming from different sources. 
For instance, some event are pure kernel counters, 
in this case they are called `software events`. Examples include: context-switches, minor-faults.

Another source of events is the processor itself and its Performance Monitoring Unit (PMU). 
It provides a list of events to measure micro-architectural events such as the number of cycles, 
instructions retired, L1 cache misses and so on. 
Those events are called PMU hardware events or hardware events for short. 
They vary with each processor type and model.

The `perf_events` interface also provides a small set of common hardware events monikers. 
On each processor, those events get mapped onto an actual events provided by the CPU, 
if they exists, otherwise the event cannot be used. 
Somewhat confusingly, these are also called hardware events and hardware cache events.

Finally, there are also tracepoint events which are implemented by the kernel ftrace infrastructure. 
Those are only available with the 2.6.3x and newer kernels.

CPU周期(cpu-cycles)是默认的性能事件, 
所谓的CPU周期是指CPU所能识别的最小时间单元, 
通常为亿分之几秒, 是CPU执行最简单的指令所需要的时间, 
例如读取寄存器的内容, 也叫做`clock tick`

性能事件的分布:
```
hw: Hardware event, 9个
sw: Software event, 9个
cache: Hardware cache event, 26个
tracepoint: Tracepoint event, 775个
```
sw实际上是内核的计数器, 与硬件无关; 
hw和cache是CPU架构相关的, 依赖于具体硬件; 
tracepoint是基于内核的ftrace, 主线2.6.3x以上的内核版本才支持

### `perf list`, 查看支持的性能事件

To obtain a list of supported events: `perf list`

`perf list`用来查看perf所支持的性能事件, 有软件的也有硬件的

An event can have sub-events (or unit masks). 
On some processors and for some events, it may be possible to combine unit masks and measure when either sub-event occurs. 
Finally, an event can have modifiers, i.e., filters which alter when or how the event is counted.

`Hardware events`: PMU hardware events are CPU specific and documented by the CPU vendor. 
  The perf tool, if linked against the libpfm4 library, provides some short description of the events. 
  For a listing of PMU hardware events for Intel and AMD processors, see
+ Intel PMU event tables: Appendix A of manual [here](http://www.intel.com/Assets/PDF/manual/253669.pdf)
+ AMD PMU event table: section 3.14 of manual [here](http://support.amd.com/us/Processor_TechDocs/31116.pdf)

## References

+ <https://perf.wiki.kernel.org/index.php/Tutorial>

