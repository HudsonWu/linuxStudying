# perf sched

操作系统调度器

```
# low-overhead recording of arbitrary workloads
perf sched record

# output per task latency metrics
perf sched latency

# show summary/map of context-switching
# 提供总的视图，将调度时间进行总结
perf sched map

# output finegrained trace
# 提供最详细，最底层的细节报告
perf sched trace

# replay a captured workload using simlated threads
# 模拟perf.data文件中所记录的调度场景
perf sched replay
```

一般使用`perf sched record`收集调度相关的数据，然后使用`perf sched latency`查看诸如调度延迟等和调度相关的统计数据。

```
# record full system activity for 10 seconds
perf sched record sleep 10

# report latencies sorted by max
perf sched latency --sort max

# 根据时间点详细地找到最大延迟相应的地方
perf sched script

# 显示了系统任务在CPU之间的分布
perf sched map

# 模拟perf.data文件中所记录的调度场景
perf sched replay
```
