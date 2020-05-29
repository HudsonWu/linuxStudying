# perf probe

tracepoint是静态检查点，如果想动态地插入监测点可以使用`perf probe`。

示例：Linux 2.6.33
```
# 在内核函数 schedule() 的第 12 行处加入了一个动态 probe 点，
# 和 tracepoint 的功能一样，内核一旦运行到该 probe 点时，便会通知 perf。
# 可以理解为动态增加了一个新的 tracepoint
perf probe schedule:12 cpu

# 使用这个添加的probe点
perf record -f -e probe:schedule -a sleep 1
perf report
```
