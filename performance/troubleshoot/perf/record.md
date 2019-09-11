# `perf-record`, 收集采样信息

Run a command and record its profile into perf.data. 
This command runs a command and gathers a performance counter profile from it, into perf.data, 
without displaying anything. This file can then be inspected later on, using perf report.

收集采样信息, 并将其记录在数据文件中. 
随后可以通过其它工具(perf-report)对数据文件进行分析

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
