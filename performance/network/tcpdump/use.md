# tcpdump基本使用

## 常用命令

```
tcpdump -i eth0 port 80 -A -s 0
tcpdump -i eth0 icmp
```

## 用法介绍

```
tcpdump -D  # 列出可用的网卡列表

tcpdump -i any  # 抓取所有网卡的数据包
tcpdump -i eth0

tcpdump -i eth0 -w debug.cap  # 把捕获的包数据写入到文件中
tcpdump -i eth0 -w -  # 输出到标准输出
tcpdump -i eth0 -w debug.cap -C 1  # 限制文件的最大大小, 超出时新开一个文件(单位: 1000000 bytes)
tcpdump -r debug.cap  # 从文件中读取包数据

tcpdump -v  # 输出包的附加信息
tcpdump -vv

tcpdump -i eth0 -c 100  # 设置抓取到多少个包后退出
tcpdump -s 0  # snaplen, 抓取长度, 为0时表示自动选择合适的长度来抓取数据包
tcpdump -S  # 打印TCP数据包的顺序号时, 使用绝对的顺序号, 而不是相对的顺序号

tcpdump -n  # 直接显示ip, 不解析为域名
tcpdump -nn  # 直接显示协议和端口号, 不要转换为协议名称

# 常用参数组合
tcpdump -i eth0 -nnS -s 0 -c 100 -Avvv [<expression>]
tcpdump -i eth0 -nnS -s 1024 -c 100 -Avvv [<expression>]
tcpdump -i eth0 -nnS -s 1024 -C 10 -c 10000 -v -w debug.cap [<expression>]
```

```
tcpdump host 192.168.8.3 -Avv
tcpdump dst host baidu.com and dst port 80 -i eth0 -vv
tcpdump dst host baidu.com and not dst port 80 -i eth0 -vv
tcpdump dst host baidu.com and not \(dst port 80 or dst port 443\) -i en0 -vv
tcpdump dst host baidu.com and 'tcp[tcpflags] & (tcp-syn) != 0'
```
