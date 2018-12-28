# Linux平台的开源监控工具 

Linux 平台下的监控方法基本上可以分为两种:
+ 通过外部检测命令或者代理程序获得被监控主机的相关状态
    + 代表工具: `Nagios`、`Munin`、`Ganglia`
+ 通过 SNMP 协议来实现对服务器和网络设备的监控工作
    + 代表工具: `Cacti`

其中 `Nagios`可以使用 `check_snmp`命令, 或者自己写脚本来使用SNMP协议获取数据


+ [Nagios, IT基础设施监控系统](https://github.com/HudsonWu/linuxStudying/tree/master/performance/real-time/nagios)
+ [Prometheus, 集群监控系统](https://github.com/HudsonWu/linuxStudying/tree/master/performance/real-time/prometheus)
