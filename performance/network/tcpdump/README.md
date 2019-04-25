# tcpdump, 抓包工具

tcpdump 是一个运行在命令行下的抓包工具. 它允许用户拦截和显示连接到该计算机的TCP/IP发送或接收网络和其他数据包.

tcpdump 适用于大多数的类Unix操作系统(如linux,BSD等). 类Unix系统的 tcpdump 需要使用libpcap这个捕捉数据的库就像 windows下的WinPcap. 


## 命令格式及常用参数

Tcpdump的大概形式如下

`tcpdump –i eth0 'port 1111' -X -c 3`

-X告诉tcpdump命令, 需要把协议头和包内容都原原本本的显示出来（tcpdump会以16进制和ASCII的形式显示), 这在进行协议分析时是绝对的利器. 

tcpdump采用命令行方式, 它的命令格式为: 

```
tcpdump [ -adeflnNOpqStvx ] [ -c 数量 ] [ -F 文件名 ]
       [ -i 网络接口 ] [ -r 文件名] [ -s snaplen ]
                   [ -T 类型 ] [ -w 文件名 ] [表达式 ]
```

tcpdump的选项介绍:

```
-a    将网络地址和广播地址转变成名字
-d    将匹配信息包的代码以人们能够理解的汇编格式给出
-dd   将匹配信息包的代码以c语言程序段的格式给出
-ddd  将匹配信息包的代码以十进制的形式给出
-e    在输出行打印出数据链路层的头部信息, 包括源mac和目的mac, 以及网络层的协议
-f    将外部的Internet地址以数字的形式打印出来
-l    使标准输出变为缓冲行形式
-n    指定将每个监听到数据包中的域名转换成IP地址后显示, 不把网络地址转换成名字
-nn   指定将每个监听到的数据包中的域名转换成IP、端口从应用名称转换成端口号后显示
-p    将网卡设置为非混杂模式, 不能与host或broadcast一起使用
-t    在输出的每一行不打印时间戳
-v    输出一个稍微详细的信息, 例如在ip包中可以包括ttl和服务类型的信息
-vv   输出详细的报文信息

-c    在收到指定的包的数目后, tcpdump就会停止
-F    从指定的文件中读取表达式,忽略其它的表达式

-i    指定监听的网络接口
-r    从指定的文件中读取包(这些包一般通过-w选项产生)
-w    直接将包写入文件中, 并不分析和打印出来
-s snaplen   snaplen表示从一个包中截取的字节数. 0表示包不截断, 抓完整的数据包. 默认的话 tcpdump 只显示部分数据包,默认68字节. 
-T    将监听到的包直接解释为指定的类型的报文, 常见的类型有rpc （远程过程调用)和snmp（简单网络管理协议)

-A    以ASCII码方式显示每一个数据包(不会显示数据包中链路层头部信息), 在抓取包含网页数据的数据包时, 可方便查看数据
-x    打印每个包的头部数据, 同时会以16进制打印出每个包的数据
-xx   打印每个包的头部数据, 同时会以16进制打印出每个包的数据, 包括数据链路层的头部
-X    告诉tcpdump命令, 需要把协议头和包内容都原原本本的显示出来（tcpdump会以16进制和ASCII的形式显示), 这在进行协议分析时是绝对的利器. 
-XX   打印每个包的头部数据, 同时会以16进制和ASCII码形式打印出每个包的数据, 包括数据链路层的头部
```

```
1. 抓取回环网口的包: tcpdump -i lo
2. 防止包截断: tcpdump -s0
3. 以数字显示主机及端口: tcpdump -n

如键入命令: tcpdump –i eth0 'port 1111' -X -c 3
```

## 常用过滤规则

一般包含三种修饰符的组合:
+ type, 指定id所代表的对象类型, id可以是名字或者数字, 可选的对象类型有: host(默认), net, port, portrange
+ dir, 描述id所对应的传输方向, 即发往id还是从id接收, 可取的方向有: src, dst, scr or dst, src and dst
+ proto, 描述id所属的协议, 可选的协议有: ether, fddi, tr, wlan, ip, ip6, arp, rarp, decnet, tcp, udp

通过`\( xxx \)`和bool操作符可以组合多种过滤规则, 一对括号是一组:
+ 否定操作: `!`或`not`
+ 与操作: `$$`或`and`
+ 或操作: `||`或`or`

```
dst host baidu.com  # 过滤目标域名
host 192.168.1.3  # 源ip或者目标ip
src host 192.168.1.3  # 源ip
net 192.168.0.0/24
net 192.168.0.0 mask 255.255.255.0

port 80
not port 80
host www.example.com and not \(port 80 or port 25\)
host www.example.com and not port 80 and not port 25
tcp portrange 1501-1549
(tcp[0:2] > 1500 and tcp[0:2] < 1550) or (tcp[2:2] > 1500 and tcp[2:2] < 1550)

'tcp[tcpflags] & (tcp-syn) !=0'  # 过滤tcp SYN消息包
'tcp[tcpflags] & (tcp-syn|tcp-ack) !=0'  # 过滤tcp SYN/ACK消息包
'tcp[0:2] > 1024'  # 源端口大于1024的TCP数据包

'tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x47455420'  # 过滤GET请求
# >>> list(map(hex, [ord(x) for x in 'GET ']))
# ['0x47', '0x45', '0x54', '0x20']

'tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x504f5354 && tcp[((tcp[12:1] & 0xf0) >> 2) + 4:1] = 0x20'
# >>> list(map(hex, [ord(x) for x in 'POST ']))
# ['0x50', '0x4f', '0x53', '0x54', '0x20']

# 自动生成HTTP相关过滤规则的脚本
# https://www.wireshark.org/tools/string-cf.html
```
