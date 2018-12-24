# ip

show / manipulate routing, devices, policy routing and tunnels (显示或操纵linux主机的路由、网络设备、策略路由和隧道)

```
Usage: ip [ OPTIONS ] OBJECT { COMMAND [ARGUMENTS] | help }
       ip [ -force ] -batch filename

where  OBJECT 管理或者获取信息的对象
         := { link | address | addrlabel | route | rule | neigh | ntable |
                   tunnel | tuntap | maddress | mroute | mrule | monitor | xfrm |
                   netns | l2tp | fou | macsec | tcp_metrics | token | netconf | ila |
                   vrf }
       OPTIONS 修改ip行为或改变其输出的选项
         := { -V[ersion] | -s[tatistics] | -d[etails] | -r[esolve] |
                    -h[uman-readable] | -iec |
                    -f[amily] { inet | inet6 | ipx | dnet | mpls | bridge | link } |
                    -4 | -6 | -I | -D | -B | -0 |
                    -l[oops] { maximum-addr-flush-attempts } | -br[ief] |
                    -o[neline] | -t[imestamp] | -ts[hort] | -b[atch] [filename] |
                    -rc[vbuf] [size] | -n[etns] name | -a[ll] | -c[olor]}
       COMMAND 针对指定对象执行的操作, 如果没有指定, 会使用默认命令list
         := { add | delete | set | show | list }
       ARGUMENTS 命令的一些参数, 支持两种类型: flag(关键字)和parameter(关键字加一个数值), 默认参数为dev
```

## ip link

You can configure interface parameters like MAC, MTU, status etc using "ip link"

1. List available interfaces

```
ip link show  //显示网络接口信息
ip link list  //显示网络设备的运行状态
ip -s link list  //显示更加详细的设备信息
ip link | grep ^[0-9] | awk -F: '{print $2}'  //获取主机所有网络接口

//当需要获取一个特定网络接口信息时, 在网络接口前添加选项ls
//使用多个选项-s会给你更详细的信息, 在排除网络连接故障时非常有用
ip -s -s link ls enp0s3
```

2. To make interface up (or down)

```
ip link set dev eth0 down  //关闭网卡
ip link set dev eth0 up  //开启网卡

ip link set eth0 promisc on  //开启网卡的混杂模式
ip link set eth0 promisc off  //关闭网卡的混杂模式
```

3. To change MAC address

```
ip link set addr 00:11:22:33:44:55 dev eth0
```

4. To change MTU, txqueuelen

```
ip link set mtu 1000 dev eth0  //设置网卡的最大传输单元

ip link set eth0 txqueuelen 1200  //设置网卡队列长度
```

5. To change interface name

```
ip link set name eth0 dev enp0s3
```

## ip address

"ip addr" can be used to add, delete, replace and show IP address of an interface.

1. Checking IP address and status

```
ip -brief address
ip -bri addr
ip -bri a
ip -bri -c a  //-c, get the output in color
ip -bri -4 a  //IPv4
ip -bri -6 a  //IPv6

ip address show  //more detailed information
ip a
```

2. Using IPv4 protocol
```
ip addr add 192.0.2.11/24 dev eth0    //add ip address to eth0 interface
ip addr del 192.0.2.10/24 dev wlan0    //remove ip address from wlan0 interface
```

Note: "ip" command allows configuring multiple ip address in one interface; If multiple ip addresses are configured, you can delete all address using "flush"
```
ip addr flush dev eth0
```

3. Using IPv6 protocol
```
ip -6 addr add 2001:db8::10/64 dev wlan0    //add ipv6 address to wlan0 interface
ip -6 addr del 2001:db8::11/64 dev eth0    //remove ipv6address from eth0 interface
```

4. Add default route
```
ip route add default via 192.0.2.1    //IPv4
ip -6 route add default via fe80::1    //IPv6
```

5. Show IP routing table
```
ip route show    //IPv4
ip -6 route show    //IPv6
```

## ip neighbor

ip neighbor command provides options to work with ARP table. You can add, delete, replace or flush entries in the ARP table using this command.

1. To check ARP table

```
ip neighbor show
ip n

ip neigh list
```

2. To add or delete an entry in ARP table

```
ip neighbor add 192.168.0.150 lladdr 00:11:22:33:44:55 dev wlp3s0
ip neighbor del 192.168.0.150 lladdr 00:11:22:33:44:55 dev wlp3s0
```

3. To clear ARP cache

```
ip neighbor flush dev wlp3s0
```

## ip route

"ip route" can be used to check the routing table, manipulate routes and default gateway.

1. To check the routing table

```
ip route show  //显示系统路由
ip r

ip -6 route show
ip -6 r

ip route list  //查看路由信息
```

2. To add a static route

```
ip route add 192.168.2.0/24 via 192.168.0.2
```

3. To delete a route

```
ip route del 192.168.2.0/24
```

4. To add a default route

```
ip route add default via 192.168.0.3
```

5. Check which path is selected to reach a destination

```
ip route get 4.2.2.2
```

## Reference

<http://www.dyxd-auto.com/file/789921426316633.pdf>
<https://wangchujiang.com/linux-command/c/ip.html>
