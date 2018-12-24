# iproute2工具套装

iproute2是linux下管理TCP/IP网络和流量控制的新一代工具包, 旨在替代老派的工具链net-tools(ifconfig, arp, route, netstat等命令)

## iproute2 和 net-tools区别

1. net-tools是通过procfs和ioctl系统调用去访问和改变内核网络配置, 而iproute2则通过netlink套接字接口与内核通讯

2. net-tools的用法给人的感觉是比较乱, 而iproute2的用户接口相对net-tools来说, 更加直观, 如各种网络资源(link, ip地址, 路由和隧道等)均使用合适的对象抽象去定义, 使得用户可以使用一致的语法去管理不同的对象


## iproute2命令介绍

iproute是linux下的网络配置工具, 该工具包含以下组件
```
rpm -ql iproute | grep bin

/sbin/cbq    # 流量控制
/usr/sbin/ifcfg    # 网络地址配置管理, 类似于ifconfig命令, 是bash shell脚本, 调用ip命令
/usr/sbin/ip    # 主要的配置命令, 可以配置IPv4和IPv6
/usr/sbin/tc    # 主要的配置命令, 用来进行流量控制(traffic control)
/usr/sbin/rtmon    # rtmon listens on netlink socket and monitors routing table changes
                   # rtmon命令是用来产生链接、地址、路由信息记录文件的命令
/usr/sbin/arpd    # 收集arp信息保存到本地cache daemon
/usr/sbin/lnstat    # 网络统计信息
/usr/sbin/nstat    # 显示网络统计信息
/usr/bin/rtacct    # 查看数据包流量状态
/usr/sbin/ss    # 类似netstat命令, 显示活动连接

# nstat and rtacct are simple tools to monitor kernel snmp counters and network interface statistics
```

### ip命令

iproute2的核心命令是ip

+ `ip link`,网络设备配置命令, 如可以启用/禁用某个网络设备, 改变mtu及mac地址等
+ `ip addr`,用于管理某个网络设备与协议(IP或IPv6)有关的地址, 与ip link类似, 不过增加了协议有关的管理(即增加了对ip地址的管理)
+ `ip addrlabel`,IPv6的地址标签, 主要用于RFC3484中描述的IPv6地址的选择, RFC3484主要介绍了两个算法, 用于IPv6(源地址和目标地址)的选择策略
+ `ip route`,管理路由, 如添加, 删除等
+ `ip rule`,管理路由策略数据库, 这里面有一个算法, 用来控制路由的选择策略
+ `ip neigh`,用于neighbor/ARP表的管理, 如显示, 插入, 删除等
+ `ip ntable`,neighbor表配置
+ `ip tunnel`,隧道配置, 隧道的作用是将数据(可以是不同协议)封装成IP包然后在互联网上将包发出
+ `ip tuntap`,管理TUN/TAP设备
+ `ip maddr`,多播地址管理
+ `ip mroute`,多播路由管理
+ `ip mrule`,多播路由策略数据库的规则
+ `ip monitor`,状态监控, 可以持续监控IP地址和路由的状态
+ `ip xfrm`,设置xfrm, xfrm是一个IP框架, 可以转换数据报的格式, 如用某个算法对数据包进行加密
+ `ip netns`,进程网络namespace管理
+ `ip l2tp`, tunnel Ethernet over IP(L2TPv3)
+ `ip tcp_metrics`, 管理TCP Metrics
+ `ip token`,标记化的接口标识符支持

## iproute2 for net-tools swappers

```
     net-tools                    iproute2

ifconfig (interface list)          ip link
ifconfig (ip configuration)        ip addr
ifconfig (interface stats)         ip -s link
route                              ip route
arp                                ip neigh
brctl addbr                 ip link add ... type bridge
brctl addif                      ip link set master
netstat                               ss
netstat -M                         conntrack -L
netstat -g                          ip maddr
netstat -i                          ip -s link
netstat -r                          ip route
iptunnel                            ip tunnel
ipmaddr                             ip maddr
tunctl                           ip tuntap (since iproute-2.6.34)
(none) for interface rename      ip link set dev OLDNAME name NEWNAME
```
