# Linux Performance Analysis and Tools

+ [dstat, 强大的系统资源统计工具](https://github.com/HudsonWu/linuxStudying/blob/master/performance/dstat.md)
+ [glances, glances an eye on your system](https://github.com/HudsonWu/linuxStudying/blob/master/performance/glances.md)
+ [htop, 交互式的进程查看器](https://github.com/HudsonWu/linuxStudying/blob/master/performance/htop.md)
+ [top, Linux Process Monitoring](https://github.com/HudsonWu/linuxStudying/blob/master/performance/top.md)

## [cpu相关知识和信息获取命令](https://github.com/HudsonWu/linuxStudying/tree/master/performance/cpu)
    
+ [dmidecode, 查看硬件信息](https://github.com/HudsonWu/linuxStudying/blob/master/performance/cpu/dmidecode.md)
+ [Get CPU Information](https://github.com/HudsonWu/linuxStudying/blob/master/performance/cpu/get_cpu_info.md)
+ [浅析CPU中断技术](https://github.com/HudsonWu/linuxStudying/blob/master/performance/cpu/interrupt.md)
+ [cpu显示信息解释](https://github.com/HudsonWu/linuxStudying/blob/master/performance/cpu/output.md)
+ [lspci, 显示所有PCI总线信息以及PCI设备信息](https://github.com/HudsonWu/linuxStudying/blob/master/performance/cpu/lspci.md)

## [内存相关知识和查询命令](https://github.com/HudsonWu/linuxStudying/tree/master/performance/memory)

+ [虚拟内存原理](https://github.com/HudsonWu/linuxStudying/blob/master/performance/memory/vm.md)
+ [swap, 实现虚拟内存的重要概念](https://github.com/HudsonWu/linuxStudying/blob/master/performance/memory/swap.md)
+ [buffer和cache](https://github.com/HudsonWu/linuxStudying/blob/master/performance/memory/buffer_cache.md)
+ [vmstat, 监视内存使用情况](https://github.com/HudsonWu/linuxStudying/blob/master/performance/memory/vmstat.md)
+ [free, 查询可用内存](https://github.com/HudsonWu/linuxStudying/blob/master/performance/memory/free.md)
+ [pmap, 进程的内存使用](https://github.com/HudsonWu/linuxStudying/blob/master/performance/memory/pmap.md)

## [磁盘管理](https://github.com/HudsonWu/linuxStudying/tree/master/performance/disk)

+ [存储设备信息获取](https://github.com/HudsonWu/linuxStudying/blob/master/performance/disk/collect_info.md)
+ [fdisk, 创建和维护分区表](https://github.com/HudsonWu/linuxStudying/blob/master/performance/disk/fdisk.md)
+ [du, 显示目录或文件占用的磁盘空间](https://github.com/HudsonWu/linuxStudying/blob/master/performance/disk/du.md)
+ [df, 检查文件系统磁盘空间](https://github.com/HudsonWu/linuxStudying/blob/master/performance/disk/df.md)
+ [dd, 读取, 转换并输出数据](https://github.com/HudsonWu/linuxStudying/blob/master/performance/disk/dd.md)
+ [mount, 磁盘挂载](https://github.com/HudsonWu/linuxStudying/blob/master/performance/disk/mount.md)
+ [挂载实例](https://github.com/HudsonWu/linuxStudying/blob/master/performance/disk/examples.md)

## [Network, 网络管理](https://github.com/HudsonWu/linuxStudying/tree/master/performance/network)

+ [netcat, 网络工具中的瑞士军刀](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/netcat.md)
+ [iproute2工具包, 管理网络和流量统计](https://github.com/HudsonWu/linuxStudying/tree/master/performance/network/iproute2)
    + [iproute2工具包介绍](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iproute2/overview.md)
    + [理解一些概念](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iproute2/concepts.md)
    + [iproute2命令集](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iproute2/commands.md)
    + [ip命令](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iproute2/ip.md)
    + [tc命令](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iproute2/tc.md)
    + [ss, 显示活动的网络连接](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iproute2/ss.md)
+ [网络监控工具](https://github.com/HudsonWu/linuxStudying/tree/master/performance/network/monitor)
    + [监控工具概览](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/monitor/overview.md)
+ [iptables, 命令行防火墙工具](https://github.com/HudsonWu/linuxStudying/tree/master/performance/network/iptables)
    + [iptables原理分析](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iptables/principle.md)
    + [iptables命令使用](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iptables/use.md)
    + [firewalld, iptables的前端控制器](https://github.com/HudsonWu/linuxStudying/tree/master/performance/network/iptables/firewalld)
        + [firewalld原理分析](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iptables/firewalld/theory.md)
        + [firewall-cmd命令使用](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/iptables/firewalld/use.md)
+ [snmp, 简单网络管理协议](https://github.com/HudsonWu/linuxStudying/tree/master/performance/network/snmp)
    + [snmp协议介绍](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/snmp/overview.md)
    + [net-snmp工具](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/snmp/net-snmp.md)
    + [安装与使用](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/snmp/use.md)
+ [无线网络](https://github.com/HudsonWu/linuxStudying/tree/master/performance/network/wireless)
    + [连接到wireless performance/network](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/wireless/wireless.md)
    + [wpa_supplicant, 无线网络管理和配置工具](https://github.com/HudsonWu/linuxStudying/blob/master/performance/network/wireless/wpa_supplicant)
    + [配置文件](https://github.com/HudsonWu/linuxStudying/tree/master/performance/network/wireless/conf)

## [进程管理](https://github.com/HudsonWu/linuxStudying/tree/master/performance/process)

+ [ps, 进程查看器](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/ps.md)
+ [pstree, 以树状图显示进程间关系](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/pstree.md)
+ [lsof, list open files](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/lsof.md)
+ [uptime, 查看系统平均负载](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/uptime.md)
+ [kill, 终止进程](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/kill.md)
+ [fg, bg, jobs](https://github.com/HudsonWu/linuxStudying/blob/master//performance/process/jobs.md)
+ [IPC, 进程间通信](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/ipc.md)
+ [proc文件系统, 访问系统内核信息的接口](https://github.com/HudsonWu/linuxStudying/blob/master/performance/process/procfs.md)
+ [supervisor, 进程管理工具](https://github.com/HudsonWu/linuxStudying/tree/master/performance/process/supervisor)

## [故障检测, 寻找系统瓶颈](https://github.com/HudsonWu/linuxStudying/tree/master/performance/troubleshoot)

+ [dmesg, 显示开机信息](https://github.com/HudsonWu/linuxStudying/blob/master/performance/troubleshoot/dmesg.md)
+ [How to Impose High CPU Load and Stress Test](https://github.com/HudsonWu/linuxStudying/blob/master/performance/troubleshoot/high-cpu-load.md)
+ [strace, 跟踪进程中的系统调用](https://github.com/HudsonWu/linuxStudying/blob/master/performance/troubleshoot/strace.md)
+ [tuned-adm, 性能调优工具](https://github.com/HudsonWu/linuxStudying/blob/master/performance/troubleshoot/tuned-adm.md)

## [Linux平台的开源监控工具](https://github.com/HudsonWu/linuxStudying/tree/master/performance/real-time)

+ [Nagios, IT基础设施监控系统](https://github.com/HudsonWu/linuxStudying/tree/master/performance/real-time/nagios)
+ [Prometheus, 集群监控系统](https://github.com/HudsonWu/linuxStudying/tree/master/performance/real-time/prometheus)


## References

+ [glances](https://github.com/nicolargo/glances)
+ [linux-performance-analysis-and-tools](http://mingxinglai.com/cn/2013/06/linux-performance-analysis-and-tools)
+ [Linux Tools Quick Tutorial](https://linuxtools-rst.readthedocs.io/zh_CN/latest/index.html)
+ [linux-performance-commands](https://geekflare.com/linux-performance-commands)

