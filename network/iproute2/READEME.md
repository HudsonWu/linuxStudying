ip地址管理
  1. 显示ip地址
    ip a
    ip address show
    ip addr show dev eth0
    ip a sh eth0
  2. 增加/删除地址
    ip address add 192.0.2.1/24 dev eth0
    ip addr del 192.0.2.2/24 dev eth0
  3. 显示接口统计
    ip -s link ls eth0

网卡和链路配置
  1. 显示链路
    ip link show
    ip link sh eth0
  2. 修改接口状态
    ip link set eth0 up
    ip link s gre01 down

路由表管理
  1. 显示路由表
    ip route
    ip ro show dev gre01
  2. 增加新路由
    ip route add 10.2.2.128/27 dev gre01
  3. 增加默认路由
    ip route add default via 192.168.1.1
  4. 修改默认路由
    ip route chg default via 192.168.1.2
  5. 删除默认路由
    ip route del default

隧道配置
  1. 增加/删除隧道
    ip tunnel add gre01 mode gre local 10.1.1.1 remote 20.2.2.1 ttl 255
    ip tunnel del gre01
  2. IPIP隧道
    ip tunl a ipip01 mode ipip local 10.1.1.1 remote 20.2.2.1 ttl 255
  3. 显示隧道
    ip tunnel show
  4. 显示隧道统计
    ip -s tunl ls gre01

邻居和arp表管理
  1. 查看arp表
    ip neigh show
  2. 手工增加/删除arp项
    ip neighbor add 10.2.2.2 dev eth0
    ip neigh del 10.2.2.1 dev eth0

socket统计
  1. 显示当前监听
    ss -l
  2. 显示当前监听的进程
    ss -p

#常用命令
    ip link show                             #显示链路
    ip addr show                             #显示地址(或ifconfig)
    ip route show                            #显示路由(route -n)
    ip neigh show                            #显示arp表(ping 192.168.95.50，如果主机在同一局域网内，直接加到arp表)
    ip neigh delete 192.168.95.50 dev eth0   #删除arp条目，条目仍然存在状态为stale，下次通信需要确认
    ip rule show                             #显示缺省规则
    ip route del default dev eth0            #删除接口路由
    ip route show table local                #查看本地静态路由
    ip route show table main                 #查看直连路由
 
#添加静态路由
    ip route add 10.0.0.0/24 via 192.168.92.129
    ip route add 10.10.10.10 via 192.168.92.129
    
    ip route add 172.31.100.0/24 dev eno16777736
    ip route add 172.32.0.2 dev eno16777736
 
#查看路由表
    [root@localhost ~]# ip route show table main
 
#删除
    ip route del 10.0.0.0/24
    ip route del 10.10.10.10
    
    ip route del 172.31.100.0/24
    ip route del 172.32.0.2
 
#再次查看路由表
    [root@localhost ~]# ip route show table main
    [root@localhost ~]# ip route show table local
 
#添加网卡别名
    ip addr add 192.168.0.11/24 dev eno16777736
 
#查看下网卡，别名没有产生，而是直接继承
    [root@localhost ~]# ip addr show eno16777736
       
#添加网卡别名并添加标记    label
    ip addr add 192.168.1.2 label eno16777736:0 dev eno16777736
 
#查看下，多了eno16777736:0
    ip addr show eno16777736
