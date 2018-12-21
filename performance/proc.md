# /proc文件系统

## 从/proc文件系统获取相关的性能参数

cpu使用率: /proc/stat

内存使用情况: /proc/meminfo

网络负载信息: /proc/net/dev

相应的计算方法: 处理器使用率, 内存使用率, 流入流出数据包, 整体网络负载
这些数据分别要从/proc/stat、/proc/net/dev、/proc/meminfo三个文件中提取. 如里有问题或对要提取的数据不太清楚, 可以使用man proc来查看proc文件系统的联机手册 

### 处理器使用率

这里要从/proc/stat中提取四个数据: 用户模式(user)、低优先级的用户模式(nice)、内核模式(system)以及空闲的处理器时间(idle). 它们均位于/proc/stat文件的第一行. CPU的利用率使用如下公式来计算

CPU利用率 = 100 * (user + nice + system) / (user + nice + system + idle)

### 内存使用率

这里需要从/proc/meminfo文件中提取两个数据, 当前内存的使用量(cmem)以及内存总量(amem)

内存使用百分比 = 100 * (cmem / umem)

### 网络利用率

为了得到网络利用率的相关数据, 需要从/proc/net/dev文件中获得两个数据: 从本机输出的数据包数, 流入本机的数据包数. 它们都位于这个文件的第四行

性能收集程序开始记录下这两个数据的初始值, 以后每次获得这个值后均减去这个初始值即为从集群启动开始从本节点通过的数据包

利用上述数据计算出网络的平均负载, 方法如下: 

平均网络负载 = (输出的数据包 + 流入的数据包) / 2

## 通过/proc文件系统调整相关的内核配置

允许ip转发  `/proc/sys/net/ipv4/ip_forward`

禁止ping  `/proc/sys/net/ipv4/icmp_echo_ignore_all`

可以在命令行下直接往上述两个"文件"里头写入"1"来实现相关配置, 如果写入"0"将取消相关配置. 不过在系统重启以后, 这些配置将恢复默认设置, 所以, 如果想让这些修改生效, 可以把下面的配置直接写入/etc/profile文件, 或者其他随系统启动而执行的程序文件中
```
echo 1 > /proc/sys/net/ipv4/ip_forward  
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all  
```
如果需要获取其他的性能参数, 或者需要对内核进行更多的配置, 可以参考proc文件系统介绍, 也可以直接通过man proc查看相关的信息
