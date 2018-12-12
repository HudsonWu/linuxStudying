## htop, 交互式的进程查看器

htop是一款基于ncurses的Linux进程查看器

与top相比, 有以下优点: <br/>
> + 启动快
> + 杀进程时不需要输入进程号
> + 可以横向或纵向滚动浏览进程列表, 以便看到所有的进程和完整的命令
> + 支持鼠标操作

```
1. Delay between data updates, in tenths of seconds
htop -d 5
htop --delay=10

2. Disable colors
htop -C
htop --no-color
htop --no-colour

3. Show only the process of a given user
htop -u nixcraft
htop --user=nginx
```

## glances

glances是一个用于监控系统的跨平台, 基于文本模式的命令行工具 <br/>
由Python编写, 使用psutil库从系统获取信息 <br/>
主要特性之一是可以在配置文件中设置阈值 (`careful`, `warning`, `critical`), 然后用不同颜色显示信息以表明系统的瓶颈 <br/>

### 功能

+ CPU平均负载
+ 不同状态进程的数量
+ 所有内存信息
+ CPU信息
+ 网络连接的上行/下行速度
+ 磁盘I/O 读/写速度详细信息
+ 当前挂载设备的磁盘使用情况
+ 消耗资源最多的进程和他们的CPU/内存使用情况

### 命令选项

```
-b, 显示网络连接速度 Byte/s
-B IP|host, 绑定服务器端IP地址或主机名称
-c IP|host, 连接glances服务器端
-C file, 设置配置文件, 默认/etc/glances/glances.conf
-d, 关闭磁盘I/O模块
-e, 显示传感器温度
-f file, 设置输出文件 (格式是HTML或CSV)
-m, 关闭挂在的磁盘模块
-n, 关闭网络模块
-p PORT, 设置运行端口, 默认是61209
-P password, 设置客户端/服务器密码
-s, 设置glances运行模式为服务器
-t sec, 屏幕刷新的时间间隔, 单位为秒, 默认为2s, 数值许可范围: 1~32767
```

### 命令交互指令

```
m, 按内存占用排序进程
p, 按进程名称排序进程
c, 按CPU占用率排序进程
i, 按I/O频率排序进程
a, 自动排序进程
d, 显示/隐藏磁盘I/O统计信息
f, 显示/隐藏文件系统统计信息
s, 显示/隐藏传感器统计信息
y, 显示/隐藏硬盘温度统计信息
l, 显示/隐藏日志
n, 显示/隐藏网络统计信息
x, 删除警告和严重日志
h, 显示/隐藏帮助界面
q, 退出
w, 删除警告记录
```

### 不同颜色含义

默认设置下, glances的阈值设置为: careful=50, warning=70, critical=90 <br/>
可以通过/etc/glances/目录下的默认配置文件glances.conf来自定义这些阈值 <br/>

> + 绿色, 正常(OK)
> + 蓝色, 小心(careful)
> + 紫色, 警告(warning)
> + 红色, 致命(critical)

### 使用实例

```
glances
glances -t 5

//Use glances on remote systems
glances -s
glances -c 172.16.27.56

//输出
glances -o HTML -f /var/www/html
glances -o CSV -f /home/root/glances.csv
```
