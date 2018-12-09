# ps, processes status

ps命令能给出当前系统中进程的快照 <br/>

ps工具标识进程的5中状态码: <br/>
```
D  不可中断  uninterruptible sleep (usually IO)
R  运行  runnable (on run queue)
S  中断  sleeping
T  停止  traced or stopped
Z  僵死  a defunct ("zombie") process
```

## 命令参数

```
a,    显示所有进程
-a,    显示同一终端下的所有程序
-A, -e,    显示所有进程
-l,    Long format
-f,    Do full-format listing
c,    显示进程的真实名称
-N,    反向选择
e,    显示环境变量
f,    显示程序间的关系
-H,    显示树状结构
r,    显示当前终端的进程
T,    显示当前终端的所有程序
u,    指定用户的所有进程
-au,    显示较详细的资讯
-aux,    显示所有包含其他使用者的进程
-C <命令>,    列出指定命令的状况
--lines <行数>,    每页显示的行数
--width <字符数>,    每页显示的字符数
--help,    显示帮助信息
--version,    显示版本信息
```

## 输出列的含义

```
F,    代表这个程序的旗标(flag), 4代表使用者为super user
S,    代表这个程序的状态(STAT)
UID,    程序被该UID所拥有
PID,    进程ID
PPID,    上级父程序ID
C,    CPU使用的资源百分比
PRI,    Priority(优先执行顺序)
NI,    Nice值
ADDR,    kernel function, 指出该程序在内存的哪个部分, 
         如果是个running的程序, 一般就是 "-"
SZ,    使用掉的内存大小
VSZ,    使用掉的虚拟内存量 (Kbytes)
RSS,    占用的固定内存量
WCHAN,    目前这个程序是否正在运行当中, 若为-表示正在运作
TTY,    登入者的终端机位置
TIME,    使用掉的CPU时间
CMD,    所下达的指令为何
```

## 使用实例

```
ps -fp 1178  //PID
ps -f --ppid 1154  //PPID
ps -fp 2226,1154,1146
ps -t pts/1
ps -ft tty1
ps -e --forest  //进程树
ps -f --forest -C sshd
ps -ef --forest | grep -v grep | grep sshd
ps -p 1154 -o comm=  //根据进程id获取进程名
ps -C sshd -o pid=  //根据进程名获取所有pid
ps -eo comm,etime,user | grep httpd  //进程运行了多长时间
```

## 查找问题

```
1. 发现内存或CPU消耗大的进程
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head
2. 查找并杀死失去响应的进程
ps -A | grep -i stress
kill -9 2583 2584
3. 显示安全类信息
ps -eM
ps --context
ps -eo euser,ruser,suser,fuser,f,comm,label
4. 实时进程监控
watch -n 1 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
```

## 更多用法

```
ps aux | sort -rnk 4  //按内存资源的使用量对进程进行排序
ps aux | sort -rnk 3  //按CPU资源的使用量对进程进行排序
ps aux --sort -pcpu,-pmem    //根据cpu,内存的使用量对进程进行排序
```
