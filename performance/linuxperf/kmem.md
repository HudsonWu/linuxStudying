# perf kmem

专门收集内核slab分配器的相关事件，如内存分配、释放等。可以用来研究程序在哪里分配了大量内存，或者在什么地方产生碎片之类和内存管理相关的问题。

perf kmem和perf lock实际上是tracepoint的特例，完全可以用`perf record -e kmem:*`或者`perf record -e lock:*`来完成同样的功能。但重要的是，这些工具在内部对原始数据进行了汇总和分析，因而能够产生信息更加明确更加有用的统计报表。

```
perf kmem --alloc -l 10 --caller stat
```
