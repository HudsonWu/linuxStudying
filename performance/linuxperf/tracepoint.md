# 使用tracepoint

使用tracepoint的基本需求是对内核的运行时行为的关心，有些内核开发人员需要专注与特定的子系统，比如内存管理模块，这便需要统计相关内核函数的运行情况。（tracepoint是静态检查点）

例子：`sys_enter`这个tracepoint的使用：
```
perf stat -e raw_syscalls:sys_enter ls

perf record -e raw_syscalls:sys_enter ls
perf report
```
