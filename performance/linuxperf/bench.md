# perf bench

benchmark是衡量性能的标准方法，对于同一个目标，如果能够有一个大家都承认的benchmark，将非常有助于提高内核性能这项工作。

## sched message

从经典的测试程序hackbench移植而来，用来衡量调度器的性能，overhead以及可扩展性。该benchmark启动N个reader/sender进程或线程对，通过IPC（socket或者pipe）进行并发的读写。一般将N不断加大来衡量调度器的可扩展性。

```
perf bench sched messaging
```

## sched pipe

从Ingo Molnar的pipe-test-1m.c移植而来，当初Ingo的原始程序是为了测试不同的调度器的性能和公平性的，其工作原理很简单，两个进程互相通过pipe拼命地发1000000个整数，进程A发给B，同时B发给A，因为A和B互相依赖，因此加入调度器不公平，那么A和B整体所需要的时间就会更长。

```
perf bench sched pipe
```

## mem memcpy

这个是perf bench作者Hitoshi Mitake自己写的一个执行memcpy的benchmark。该测试衡量一个拷贝1M数据的memcpy()函数所花费的时间。
