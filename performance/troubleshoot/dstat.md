# dstat, versatile tool for generating system resource statistics

dstat provides valuable insights into linux system performance, pretty much replacing older tools, such as vmstat, netstat, iostat, and ifstat

dstat在性能测试、基准测试和排除故障过程中可以很方便监控系统运行状况

dstat默认输出是专门为实时查看而设计的, 也可以将详细信息通过csv输出到文件

直接使用dstat, 默认使用的是`-cdngy`参数, 分别表示cpu, disk, net, page, system信息, 默认是1s显示一条信息
```console
# dstat
You did not select any stats, using -cdngy by default.
--total-cpu-usage-- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai stl| read  writ| recv  send|  in   out | int   csw 
  0   0 100   0   0|2045B   11k|   0     0 |   2B   40B|  29    69 
  0   0 100   0   0|   0     0 | 539B 3054B|   0     0 |  39    71 
  0   0 100   0   0|   0     0 | 291B 1205B|   0     0 |  32    76 
  0   0 100   0   0|   0     0 | 154B  687B|   0     0 |  21    41 
  0   0 100   0   0|   0     0 | 154B  996B|   0     0 |  25    60
```

一些字段解释
```
hiq, siq分别为硬中断和软中断次数
stl, 虚拟机偷取时间
int, 系统的中断次数(interrupt)
csw, 上下文切换(context switch)
```

## 语法

dstat [-afv] [options..] [delay [count]]

常用选项
```
-c, --cpu: 开启cpu统计
-C: 该选项跟cpu的编号, 如 0,3,total 表示分别包含cpu0, cpu3和total
-d, --disk: 开启disk统计
-D: 该选项跟具体设备名, 如 total,hda,hdb 表示分别统计total, hda, hdb设备块
-g, --page: 开启分页统计
-i, --int: 开启中断统计
-I: 该选项跟中断号, 如 5,10
-l, --load: 开启负载统计
-m, --mem: 开启内存统计
-n, --net: 开启net统计
-N: 该选项跟网络设备名, 如 eth1,total
-p, --proc: 开启进程统计
-r, --io: 开启io请求统计
-s, --swap: 开启swap统计
-S: 该选项跟具体的交换区, 如 swap1,total
-t, --time: 启用时间和日期输出
-T, --epoch: 启用时间计数, 从epoch到现在的秒数
-y, --sys: 开启系统统计, 包括中断和上下文切换
--aio: 开启同步IO统计(asynchronous I/O)
--fs: 开启文件系统统计
--ipc: 开启ipc统计
--lock: 开启文件锁统计
--raw: 开启raw统计(raw socket)
--socket: 开启socket统计
--tcp: 开启tcp统计
--udp: 开启udp统计
--unix: 开启unix统计
--vm: 开启vm统计
--list: 列举内置插件扩展
-a, --all: 默认值, 相当于-cdngy
--float: 输出强制为浮点值
--integer: 输出强制为整数值,此为默认值
--nocolor: 禁用颜色
--noheaders: 禁止重复输出header, 默认会打印一屏幕输出一次header
--noupdate: 当delay>1时禁止在过程中更新(即在时间间隔内不允许更新)
--output file: 输出结果到csv文件
--profile: show profiling statistics when exiting dstat
```

命令参数
```
delay: 两次输出之间的时间间隔, 默认为1s
count: 报告输出的次数, 默认没有限制, 一直输出直到ctrl+c
```

虽然任何人可以自由地为dstat编写插件, 但dstat附带大量的插件已经大大扩展其功能

常用插件
```
--disk-util: 显示某一时间磁盘的忙碌状况
--freespace: 显示当前磁盘空间使用率
--proc-count: 显示正在运行的程序数量
--top-bio: 显示块I/O最大的进程
--top-cpu: 显示cpu占用最大的进程
--top-io: 显示正常I/O最大的进程
--top-mem: 显示占用最多内存的进程
```

## 实例

```
dstat -glms --top-mem  //内存资源使用情况
dstat -cyl --proc-count --top-cpu  //cpu资源使用情况
dstat -tdD total,sde,sdh,sdc 60  //每分钟输出一次磁盘使用情况
dstat --output ~/test.csv  //输出到文件
```

## References

+ [dstat.1.adoc](https://github.com/dagwieers/dstat/blob/master/docs/dstat.1.adoc)
+ [DAG-dstat](http://dag.wiee.rs/home-made/dstat/)
