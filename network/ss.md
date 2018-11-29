## ss(Socket Statistics)
ss命令用来获取socket统计信息, 它可以显示和netstat类似的内容, ss的优势在于它能够显示更多更详细的有关TCP和连接状态的信息, 而且更快速更高效
ss是iproute2包附带的一个工具

### 语法:
ss [参数]
ss [参数] [过滤]

### 选项:
-V, --version  程序版本信息
-n, --numeric  不解析服务名称
-r, --resolve  解析主机名
-a, --all  显示所有套接字(sockets)
-l, --listening  显示监听状态的套接字
-o, --options  显示计时器信息
-e, --extended  显示详细的套接字信息
-m, --memory  显示套接字的内存使用情况
-p, --processes  显示使用套接字的进程
-i, --info  显示TCP内部信息
-s, --summary  显示套接字使用概况
-4, --ipv4  仅显示ipv4的套接字
-6, --ipv6  仅显示ipv6的套接字
-0, --packet  显示PACKET套接字
-t, --tcp  仅显示TCP套接字
-u, --udp  仅显示UDP套接字
-d, --dccp  仅显示DCCP套接字
-w, --raw  仅显示RAW套接字
-x, --unix  仅显示unix套接字
-f, --famile=FAMILY  显示FAMILY类型的套接字, 支持unix, inet, inet6, link, netlink
-A, --query=QUERY, --socket=QUERY
    QUERY := {all|inet|tcp|udp|raw|unix|packet|netlink}[,QUERY]
-D, --diag=FILE  将原始TCP套接字信息转储到文件
-F, --filter=FILE  从文件中读取过滤器信息
    FILTER := [ state TCP-STATE ] [ EXPRESSION ]

### 例子
> ss -t -a  // 显示TCP连接
> ss -s  // 显示Socket摘要
> ss -l  // 列出所有打开的网络连接端口
> ss -pl  // 查看进程使用的socket
> ss -o state established '( dport = :smtp or sport = :smtp )'  // 显示所有状态为established的SMTP连接
> ss -o state fin-wait-1 '( sport = :http or sport = :https )' dst 193.233.7/24  // 列举出处于FIN-WAIT-1状态的源端口为80或443, 目标网络为193.233.7/24的所有tcp套接字

// 匹配远程地址和端口号
> ss dst 192.168.1.5
> ss dst 192.168.1.5:http
> ss dst 192.169.1.5:443
> ss src 192.168.119.103:http  // 匹配本地地址和端口号

// 将本地或者远程端口和一个数比较
> ss sport =:http
> ss dport \> :1024
> ss sport eq :22
> ss dport != :22
> ss state connected sport = :http
> ss \( sport = :http or sport = :https \)

// 用TCP状态过滤sockets
> ss -4 state FILTER-NAME
> ss -4 state closing
FILTER-NAME
established syn-sent syn-recv fin-wait-1 fin-wait-2 time-wait close-wait last-ack listen closed
all: 所有以上状态
connected: 除了listen和closed的所有状态
synchronized: 所有已连接的状态, 除了syn-sent
bucket: 显示状态为maintained as minisockets, 如: time-wait和syn-recv
big: 和bucket相反

### netstat
netstat -pantu | grep tor
netstat -nlt
