# vmstat, 监视内存使用情况

vmstat, Virtual Memory Statistics, 虚拟内存统计, 可实时动态监视操作系统的虚拟内存、进程、CPU活动

## 语法

```
vmstat [options] [arguments]

vmstat [-n] [delay [count]]
```

### 选项

```
-a, active, 显示活动内存页
-f, forks, 显示启动后创建的进程总数
-m, 显示slab信息
-n, 在周期性循环输出时, 头信息仅显示一次
-s, stats, 以表格方式显示时间计数器和内存状态
-d, disk, 报告磁盘状态
-p, partition, 显示指定的硬盘分区状态
-S, 输出信息的单位
-V, 显示版本信息
```

### 参数

```
时间间隔(delay): 状态信息刷新的时间间隔
次数(count): 显示报告的次数
```

## 输出字段说明

+ Procs(进程)
    + r, 运行队列中进程数量, 这个值可以判断是否需要增加CPU(长期大于1)
    + b, 等待IO的进程数量
+ Memory(内存)
    + swapd, 使用虚拟内存大小, 如果swapd值不为0, 但SI, SO值长期为0, 不影响系统性能
    + free, 可用内存大小
    + buff, 用作缓冲的内存大小
    + cache, 用作缓存的内存大小
    + inact, 非活跃内存大小
    + active, 活跃内存大小
+ Swap(内存够用时, 这两个值都是0, 如果这两个值长期大于0, 系统性能会受到影响)
    + si, 每秒从交换区写到内存的大小
    + so, 每秒写入交换区的内存大小
+ IO(块大小为1024bytes)
    + bi, 每秒读取的块数
    + bo, 每秒写入的块数
+ system(这两个值越大, 内核消耗的CPU时间会越大)
    + in, 每秒中断数, 包括时钟中断
    + cs, 每秒上下文切换数
+ CPU(以百分比表示)
    + us, 用户进程执行时间(user time), 长期超50%时, 考虑优化程序算法或进行加速
    + sy, 系统进程执行时间(system time)
    + id, 空闲时间(包括IO等待时间)
    + wa, 等待IO时间, 值高时, 可能由于磁盘大量做随机访问造成, 也可能磁盘出现瓶颈
    
## 监控指标

对于服务器监控有用处的度量主要有: r(运行队列), pi(页导入), us(用户CPU), sy(系统CPU), id(空闲)

+ CPU利用率, 用户空间进程占用CPU比例在65-70%之间, 内核CPU比例在30-35%之间, 空闲比例在0-5%之间, 一般不超过这个比例
+ 进程上下文切换, 上下文切换和CPU利用率应该联系起来, 上下文切换也是需要消耗CPU资源的, 如果CPU利用率低, 那么上下文切换稍高可以接受, 频繁的切换必将使得CPU利用率升高
+ 运行队列中等待运行的进程数, 每个CPU核心中等待处理的进程数不应该超过3个线程/进程, 如4核心的机器,那么队列的最大值应该不超过12个
+ 平均负载, 平均负载值平均每核心CPU负载应该控制在0.7, 最好不要超过1
