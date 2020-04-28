# tcpdump基本使用

+ `tcpdump [<options>] [<expressions>]`

options负责在哪(网口)、怎么抓(出栈/入栈)以及怎么打印；
而expressions则相当于filter，例如只抓tcp的包

## 参数，options

```
-t, 不打印时间戳
-n, 一个n代表不做地址转换，即打印ip地址；两个n代表不做端口转换
-e, 打印MAC地址
-i, 指定监听/抓包的网口
-x, 以十六进制打印包的内容
-A, 以Ascii码打印包的内容
-P, 指定监听或抓包的方向，in代表从网口进来，out代表从网口出去
  + redhat/centos的选项，ubuntu时-Q

可以将Options拼接在一起，但带参数的option只能放在拼接的最后
tcpdump -tnnei eth0

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

## 表达式，expressions

expressions有自己的简单语法，以及关键字

+ and, or, not  逻辑的与或非
+ &  位与
+ <<, >>  位移
+ ==  相等
+ []  使用索引(从0开始)来读取数据包中的值
  + ether[0], 读取以太网包的第0个字节
  + ip[1:2], tcp[4:3]

tcpdump自己的语法糖：

+ ether, icmp, arp, ip, tcp, udp  指定特定协议
+ src, dst  指定源或目的
+ host, net  指定ip为单个主机或网络地址

其他一些可以通过man tcpdump查看，如搜索tcpflags, icmptypes等

## 示例

```
tcpdump -tnnei eth0 arp or icmp
tcpdump -i eth0 port 80 -A -s 0
tcpdump host 192.168.8.3 or host 192.168.4 -Avv
tcpdump dst host baidu.com and dst port 80 -i eth0 -vv
tcpdump dst host baidu.com and not dst port 80 -i eth0 -vv
tcpdump dst host baidu.com and not \(dst port 80 or dst port 443\) -i en0 -vv
tcpdump dst host baidu.com and 'tcp[tcpflags] & (tcp-syn) != 0'
```
