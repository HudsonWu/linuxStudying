## Show list of network cards

1. lspci
```console
# lspci | egrep -i --color 'network|ethernet'
09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5761e Gigabit Ethernet PCIe (rev 10)
0c:00.0 Network controller: Intel Corporation Ultimate N WiFi Link 5300
```

2. lshw
```
lshw -class network
```

3. ip
```
ip link show
ip a
```

4. /proc/net/dev
The dev pseudo-file contains network device status information. This gives the number of received and sent packets, the number of errors and collisions and other basic statistics.
```
cat /proc/net/dev
```

## DHCP

```
原理
1）客户端发送广播包
2）服务器提供响应，在自己的数据库中查找可用地址交付（同样是广播包）
3）客户端确认IP，服务器确认地址已分配
4）服务器确认租约
5）当客户机重启和租期到达一半时，进行续组
如果租约到期后无法联系到DHCP服务器，客户端重新发送广播包
```

## DNS

系统判断的顺序
```
C:\Windows\System32\drivers\etc\hosts --> DNS缓存 --> DNS服务器
```
DNS服务器判断的顺序
```
本地缓存 --> 本地数据 --> 转发器
```
