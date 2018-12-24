# 网络监控工具

```
监控总体带宽使用: nload bmon slurm bwm-ng cbm speedometer netload
监控总体带宽使用(批量式输出): vnstat ifstat dstat collectl
每个套接字连接的带宽使用: iftop iptraf tcptrack pktstat netwatch trafshow
每个进程的带宽使用: nethogs
```

## nload

功能: 让用户可以分开来监控入站流量和出站流量;还可以绘制图表 <br/>
原理: 读取"proc/net/dev"文件,以获得流量统计信息 <br/>
使用场景: 需要快速查看总带宽使用情况,无需每个进程的详细情况 <br/>
安装: sudo apt-get install nload <br/>
使用: nload <br/>

## iftop

功能: 测量通过每一个套接字连接传输的数据 <br/>
原理: 使用pcap库来捕获进出网络适配器的数据包,然后汇总数据包大小和数量,搞清楚总的带宽使用情况 <br/>
优缺点: 虽然iftop报告每个连接所使用的带宽,但它无法报告参与某个套接字连接的进程名称/编号(ID); <br/>
不过由于基于pcap库,iftop能够过滤流量,并报告由过滤器指定的所选定主机连接的带宽使用情况 <br/>
安装: sudo apt-get install iftop <br/>
使用: sudo iftop -n <br/>
n选项可以防止iftop将IP地址解析成主机名,解析本身就会带来额外的网络流量 <br/>

### iptraf

描述: 一款交互式,色彩鲜艳的IP局域网监控工具 <br/>
功能: 显示每个连接与主机之间传输的数据量 <br/>
安装: sudo apt-get install iptraf iptraf-ng <br/>
使用: sudo iptraf <br/>

### nethogs

描述: 一款小巧的"net top"工具 <br/>
功能: 可以显示每个进程所使用的带宽,并对列表排序,将耗用带宽最多的进程排在最上面; <br/>
nethogs可以报告程序的进程编号(PID),用户和路径 <br/>
使用场景: 万一出现带宽使用突然激增的情况,可以迅速打开nethogs,找到导致带宽使用激增的进程 <br/>
安装: sudo apt-get install nethogs <br/>
使用: sudo nethogs <br/>

### bmon

描述: 带宽监控器,类似nload的工具 <br/>
功能: 可以显示系统上所有网络接口的流量负载;输出结果含有图表和剖面,附有数据包层面的详细信息; <br/>
bmon支持许多选项,能够制作HTML格式的报告 <br/>
安装: sudo apt-get install bmon <br/>

### slurm

描述: 另一款网络负载监控器 <br/>
功能: 显示设备的统计信息,显示ASCII图形;支持三种不同类型的图形,使用c键,s键,l键激活每种图形 <br/>
缺点: 功能简单,无法显示关于网络负载的任何进一步详细信息 <br/>
安装: sudo apt-get install slurm <br/>
使用: slurm -s -i eth0 <br/>

### tcptrack

功能: 类似iftop,使用pcap库来捕获数据包,并计算各种统计信息,比如每个连接所使用的带宽; <br/>
支持标准的pcap过滤器,这些过滤器可用来监控特定的连接 <br/>
安装: sudo apt-get install tcptrack <br/>

### vnstat

功能: 实际上运行后台服务/守护进程,始终不停地记录说传输数据的大小;可以用来制作显示网络使用历史情况的报告
使用场景: vnstat更像一款制作历史报告的工具,显示每天或过去一个月使用了多少带宽,它并不是严格意义上的实时监控网络的工具
安装: sudo apt-get install vnstat
使用:
运行没有任何选项的vnstat,只会显示自守护进程运行以来所传输的数据总量
使用"-l"选项(实时模式),会显示入站数据和出站数据所使用的总带宽量,但非常精确地显示,没有关于主机连接或进程的任何内部详细信息
vnstat -l -i eth0

### bwm-ng

描述: 下一代带宽监控器,是另一款非常简单的实时网络负载监控工具 <br/>
功能: 报告摘要信息,显示进出系统上所有可用网络接口的不同数据的传输速度; <br/>
如果控制台足够大,bwm-ng还能使用curses2输出模式,为流量绘制条形图(bwm-ng -o curses2) <br/>
安装: sudo apt-get install bwm-ng <br/>

###. cbm

描述: Color Bandwidth Meter,小巧简单的带宽监控工具 <br/>
功能: 显示通过诸网络接口的流量大小,没有进一步的选项,仅仅实时显示和更新流量的统计信息 <br/>
安装: sudo apt-get install cbm <br/>

###. speedometer

描述: 另一款小巧而简单的工具,仅仅绘制外观漂亮的图形,显示通过某个接口传输的入站流量和出站流量 <br/>
安装: sudo apt-get install speedometer <br/>
使用: speedometer -r eth0 -t eth0 <br/>

###. pktstat

功能: 实时显示所有活动连接,并显示哪些数据通过这些活动连接传输的速度; <br/>
可以显示连接的类型,比如TCP连接或UDP连接;如果涉及HTTP连接,还会显示关于HTTP请求的详细信息 <br/>
安装: sudo apt-get install pktstat <br/>
使用: sudo pktstat -i eth0 -nt <br/>

###. netwatch

描述: netwatch是netdiag工具库的一部分,它也可以显示本地主机与其他远程主机之间的连接, <br/>
并显示哪些数据在每个连接上所传输的速度 <br/>
安装: sudo apt-get install netdiag <br/>
使用: sudo netwatch -e eth0 -nt <br/>

###. trafshow

功能: 与netwatch和pktstat一样,trafshow也可以报告当前活动连接,它们使用的协议以及每条连接上的数据传输速度; <br/>
它能使用pcap类型过滤器,对连接进行过滤 <br/>
安装: sudo apt-get install netdiag <br/>
使用: sudo trafshow -i eth0 tcp <br/>

###. netload

功能: netload命令只显示关于当前流量负载的一份简短报告,并显示自程序启动以来所传输的总字节量, <br/>
没有更多的功能特性,它是netdiag的一部分 <br/>
安装: sudo apt-get install netdiag <br/>
使用: netload eth0 <br/>

###. ifstat

功能: 能够以批处理式模式显示网络带宽,输出采用的一种格式便于用户使用其他程序或实用工具来记录日志和分析 <br/>
安装: sudo apt-get install ifstat <br/>

###. dstat

描述: dstat是一款用途广泛的工具(用python语言编写) <br/>
功能: 可以监控系统的不同统计信息,并使用批处理模式来报告,或者将相关数据记入到csv或类似的文件 <br/>
使用: dstat -nt <br/>

###. collectl

功能: 以一种类似dstat的格式报告系统的统计信息, <br/>
与dstat一样,它也收集关于系统不同资源(如处理器,内存和网络等)的统计信息 <br/>
安装: sudo apt-get install collectl <br/>
使用: collectl -sn -oT -i0.5 <br/>

另外,基于web的监控工具也可以实现同样的任务 <br/>
ntop和darkstat是面向Linux系统的其中两个基本的基于web的网络监控工具 <br/>
除此之外,还有企业级监控工具,如nagios,它们提供了一批功能特性,不仅仅可以监控服务器,还能监控整个基础设施 <br/>
