# ip路由选择 (ip routing)

ip路由选择涉及对ip数据报的转发，如果与目标主机已连接，主机与目标主机的连接很简单，直接发送数据报到目标主机即可，比如通过一个点对点连接(point to point linke)或通过一个共享网络(shared network)；如果与目标主机并没有直接连接，则发送ip数据报到默认路由(default route)，让路由决定如何进一步发送ip数据报。

ip层维护了一个路由表，在决定如何处理接收到的数据报时会使用到这个路由表。当从网络接收到数据报时，ip层首先检查ip地址，如果目的ip(destination IP)是自己，则发送数据报到传输层，如果不是，当主机配置了路由功能时，则转发数据报，否则，直接丢弃。

路由表的数据通常采用条目的形式(in the form of entries)，一个典型的路由表条目包含以下主要条目：

+ 目的ip地址(Destination IP address)，这个ip地址可以是单个主机的地址，也可以是网络的地址，如果是单独的ip，则用一个非0的主机ID值表示，如果是一个网络则用主机ID值为0表示
+ 下一个路由器的ip地址(IP address of next router)
+ 标志(Flags)，此字段提供另一组重要信息，如目标ip是主机地址还是网络地址，另外，标记下一个路由器是真正的下一个路由器还是直接连接的接口
+ 网络接口规范(Network interface specs)，关于网络接口的一些规范数据报应该被传递以进行进一步的传输

下面是路由表算法的详细过程：

+ 首先在路由表中搜索Destination IP address与数据报的目标IP地址完全匹配的条目，如果发现，则发送数据报到该接口或中间路由器
  + 这里的完全匹配是指，ip地址的host ID和network ID匹配
+ 如果没有完全匹配的条目，则进行network ID的搜索，如果发现，则转发到指定路由
+ 如果还没有找到，则转发到默认路由(default router)
+ 如果上面步骤失败，比如没有默认路由，则该数据报将无法发送，任何无法交付的数据报(undeliverable datagram)都会产生`ICMP host unreachable`或者`ICMP network unreachable`的错误，该错误将返回到生成该数据报的应用程序


## 列出路由表的命令

```sh
$ netstat -rn
Kernel IP routing table
Destination  Gateway         Genmask         Flags   MSS Window  irtt Iface
192.168.2.0  0.0.0.0         255.255.255.0   U         0 0        0    eth0
169.254.0.0  0.0.0.0         255.255.0.0     U         0 0        0    eth0
0.0.0.0      192.168.2.1     0.0.0.0         UG        0 0        0    eth0
```

标记`U`表示路由可用(up)，标记`G`表示路由指向网关(gateway)，标记`H`表示目标Destination ip address是一个主机(host)

## route命令

route命令用来显示和操作ip路由表，主要用于通过接口设置到特定主机或网络的静态路由。

直接输入route命令将显示kernel routing table entries
```sh
$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     *               255.255.255.0   U     0      0        0 eth0
```

上面的命令结果，表示如果目的地址在192.168.1.0/24网段内，则网关是`*`(0.0.0.0)，当数据包在这个ip范围内发送时，通过ARP协议找到目的MAC地址，然后将数据包发送到MAC地址。

为了将包发送到不在此ip范围内的目的地，包将被转发到一个默认网关，默认route命令会在输出中显示主机名，可以使用-n选项展示ip地址。

```sh
$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
0.0.0.0         192.168.1.10    0.0.0.0         UG    0      0        0 eth0
```

### 添加网关

```sh
$ route add default gw 192.168.1.10
$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     *               255.255.255.0   U     0      0        0 eth0
default         gateway.co.in   0.0.0.0         UG    0      0        0 eth0
```

#### 示例

+ 网关 
  + 外网 125.250.60.59
  + 内网1 192.168.1.10
    + 子网: 192.168.1.0/24
  + 内网2 192.168.3.10
    + 子网: 192.168.3.0/24

让192.168.1.*和192.168.3.*可以互相访问
```
# 192.168.1.*
route add default gw 192.168.1.10

# gateway
route add -net 192.168.3.0 netmask 255.255.255.0 gw 192.168.3.10
route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.10

# 192.168.3.*
route add default gw 192.168.3.10
```

可以访问外网
```
# gateway
route add default gw 125.250.60.59
```

### 列出内核路由缓存信息 (Kernel's Routing Cache Information)

内核维护路由缓存信息以加快路由包，使用-C选项可以列出路由缓存信息

```sh
$ route -Cn
Kernel IP routing cache
Source          Destination     Gateway         Flags Metric Ref    Use Iface
192.168.1.157   192.168.1.51    192.168.1.51          0      0        1 eth0
192.168.1.157   74.125.236.69   192.168.1.10          0      0        0 eth0
.
.
.
```

### 拒绝路由到特定主机或网络

```sh
$ route add -host 192.168.1.51 reject
$ ping 192.168.1.51
connect: Network is unreachable
$ ping 192.168.1.53
PING 192.168.1.53 (192.168.1.53) 56(84) bytes of data.
64 bytes from 192.168.1.53: icmp_seq=1 ttl=64 time=7.77 ms
...
$
$ route add -net 192.168.1.0 netmask 255.255.255.0 reject
$ ping 192.168.1.51
connect: Network is unreachable
$ ping 192.168.1.52
connect: Network is unreachable
$ ping 192.168.1.53
connect: Network is unreachable
```
