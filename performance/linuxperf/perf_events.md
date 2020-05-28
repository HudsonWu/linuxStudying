# perf, 系统性能分析工具

linux系统下的perf命令，也有下面的几种名称：
+ `perf Linux profiler`
+ `Performance Counters for Linux(PCL)`
+ `Linux perf events(LPE)`
+ `perf_events`

perf是用来进行软件性能分析的工具，通过perf, 应用程序可以利用PMU(Performance Monitoring Unit), tracepoint和内核中的特殊计数器来进行性能统计。（CPU的性能计数器(CPU performance counters), tracepoints, kprobes, uprobes(dynamic tracing)）

perf是linux内核的一部分，包含在linux内核的tools/perf下。最初的时候，它叫做Performance counter，在2.6.31中第一次出现，此后它成为内核开发最为活跃的一个领域。在2.6.32中它正式改名为Performance Event，因为perf已不再仅仅作为PMU的抽象，而是能够处理所有的性能相关的事件。

perf基本原理是对目标进行取样，记录特定条件下所观察的事件是否发生以及发生的次数。

使用perf，可以分析程序运行期间发生的硬件事件，比如instructions retired, processor clock cycles等，也可以分析软件事件，比如Page Fault和进程切换。

+ `performance counters`, cpu硬件寄存器，计算硬件事件
  + 比如执行的指令(instruction executed), 缓存未命中(cache-misses suffered)或分支错误预测(branches mispredicted)
  + perf在特定于硬件的功能上提供了丰富的通用抽象，其中，它提供了每个任务(perf task)、每个cpu(per cpu)以及每个工作负载计数器(per-workload counters)之上的采样以及源代码事件标注。
+ `tracepoints`, 是位于代码中逻辑位置的工具点，比如系统调用(system calls), TCP/IP事件, 文件系统操作等。

`perf_event`是一个面向事件的可观察性工具(observability tool)，它可以帮助解决高级性能问题和故障诊断功能，它可以找到以下问题的答案：

+ 为什么内核占用cpu(kernel on-CPU)这么多，代码路径(code-paths)是什么？
+ 哪些代码路径导致了CPU二级缓存未命中(CPU leve 2 cache misses)？
+ CPU在内存I/O(memory I/O)上阻塞(stalled)了吗？
+ 哪些代码路径正在分配内存，分配了多少？
+ 是什么触发了TCP重传(TCP retransmits)？
+ 是否调用了某个内核函数，调用频率怎样？
+ 线程为什么没有使用(leaving)CPU？
