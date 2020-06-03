# 日志系统

在linux系统中, 有三个主要的日志子系统:

+ 连接时间日志
  + 由login等程序执行，把记录写入到/var/log/wtmp和/var/run/utmp文件中
+ 进程统计日志
  + 由系统内核执行, 当一个进程终止时, 为每个进程往进程统计文件psacct或acct, 写一个记录
  + 进程统计的目的是为系统中的基本服务提供命令使用统计
+ 错误日志
  + 由syslogd(8)执行, 各种系统守护进程
  + 用户程序和内核通过syslog(3)向文件/var/log/messages报告值得注意的事件
  + 另外有许多UNIX程序创建日志, 像HTTP和FTP这样提供网络服务的服务器也保持详细的日志

## 常用的日志文件

```
aculog  记录MODEM的活动
btmp  记录失败的记录
lastlog  记录最近几次成功登录的事件和最后一次不成功的登录
messages  从syslog中记录信息(有的链接到syslog文件)
sudolog  记录使用sudo发出的命令
sulog  记录使用su命令
syslog  从syslog中记录信息(通常链接到messages文件)
utmp  记录当前登录的每个用户
wtmp  一个用户每次登录进入和退出时间的永久记录
xferlog  记录FTP会话
```

## 登录日志

当有一个用户登录时，login程序在文件lastlog中查看用户的UID，如果找到了，就把用户上次登录，退出时间和主机名写到标准输出中，然后login程序在lastlog中记录新的登录时间。

在新的lastlog记录写入后，打开utmp文件并插入用户的utmp记录，该记录一直到用户登录退出时删除。utmp文件被各种命令文件使用，包括who、w、users、finger。

下一步，login程序打开wtmp文件并附加用户的utmp记录，当用户登录退出时，具有更新时间戳的同一utmp记录附加到文件中，wtmp文件被程序last和ac使用。

## 日志查看命令

```
wtmp和utmp文件都是二进制文件
who  查询utmp文件并报告当前登录的每个用户
who /var/log/wtmp  报告自wtmp文件创建或删改以来的每一次登录
w  查询utmp文件并显示当前系统中每个用户和它所运行的进程信息
users  用单独的一行显示当前登录的用户, 每个显示的用户名对应一个登录会话
last  往回搜索wtmp来显示自文件第一次创建以来登录过的用户
last root  只报告root近期活动
ac  根据当前的/var/log/wtmp文件中的登录进入和退出来报告用户连接的时间(小时)
如果不使用标志, 则报告总的时间
ac -d 显示每天总的连接时间
ac -p 显示每个用户总的连接时间
lastlog  lastlog文件每次有用户登录时被查询, 可以使用lastlog命令来检查
某特定用户上次登录的时间, 并格式化输出上次登录日志/var/log/lastlog的内容
lastlog -u 102  报告UID为102的用户
lastlog -t 7 限制上一周的报告
```

## 进程统计

与连接时间日志不同, 进程统计子系统默认不激活, 它必须启动。

acct是一个工具包, 里面包含有针对用户连接时间, 进程执行情况等进行统计的工具。
它可以记录用户登录信息, 用户所执行的程序, 程序执行情况信息等。

+ accton: 打开或关闭进程统计, 如果不带任何参数, 即关闭进程统计。
+ accton file 必须以root身份运行, file必须先存在。

一旦accton被激活, 就可以使用lastcomm命令监测系统中任何时候执行的命令。
lastcomm命令报告以前执行的文件, 。
不带参数时, lastcomm命令显示当前统计文件生命周期内记录的所有命令的有关信息。
包括命令名, 用户, tty, 命令花费的CPU时间和一个时间戳。

```
# 工具的安装
yum install psacct
apt-get install acct

ac  # 从wtmp文件获取所有用户的连接总时间, 以小时为单位
ac -d  # 每天所有用户的连接时间统计
ac -p  # 每个用户的连接总时间
ac tecmint  # 显示tecmint这个用户的连接总时间
ac -d tecmint  # 显示tecmint这个用户每天的连接时间
sa  # 显示所有用户活动信息 (re, real time, 时钟; cp, cpu时间)
sa -u  # 显示用户
sa -m  # 打印进程总数和CPU分钟
sa -c  # 百分比排序显示
lastcomm tecmint  # 列出tecmint上最近执行的命令
lastcomm ls  # 按命令查找
```
