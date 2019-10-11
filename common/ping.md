# ping

## 使用ping测试MTU

把本机的MTU设成比网关的MTU小或相同, 可以减少丢包; 如果本机的MTU比网关大, 大的数据包就会被拆开来传送, 
这样会产生很多数据包碎片, 增加丢包率

如果检测到网关的MTU值是1500, 从1400到1472之间多试几次, 就能找到合适的数据包长度了; 
把数据包长度加上数据包头28字节 (ICMP header: 8字节, IP header: 20字节), 就得到MTU的值

```
# linux
ping -c 3 -s 1472 -M do www.baidu.com

# windows
ping -l 1472 -f www.baidu.com
```
