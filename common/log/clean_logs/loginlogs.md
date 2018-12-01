<pre>
1. utmp, wtmp, btmp
/var/run/utmp  记录当前正在登录系统的用户信息, 
               默认由who和w记录当前用户的信息, uptime记录系统启动时间 (user)
/var/log/wtmp  记录当前正在登录和历史登录系统的用户信息, 默认由last命令查看 (who) 
/var/log/btmp  记录失败的登录尝试信息, 默认由lastb命令查看 (bad)

如果想禁用who命令, 则只需要将utmp的可读权限去掉就行
如果是btmp文件, 手工创建的话注意权限必须是600, 否则不能正确写入信息

2. lastlog
列出所有用户最近登录的信息, 或者指定用户的最近登录信息
lastlog引用的是/var/log/lastlog文件中的信息
包括 login-name, port, last login time

3. last
列出当前和曾经登录系统的用户信息, 默认读取的是/var/log/wtmp文件的信息
输出的内容包括: 用户名, 终端位置, 登录源信息, 开始时间, 结束时间, 持续时间
也可以使用last -f 参数指定读取文件, 可以是/var/log/btmp, /var/run/utmp

4. lastb
列出失败尝试的登录信息, 也可以使用-f参数指定读取文件, 可以是/var/log/btmp, /var/run/utmp

5. ac
输出所有用户总的连接时间, 默认单位是小时
基于wtmp统计

6. who
查看当前登录系统的用户信息
who -m 等效于 who am i
既可以读取utmp文件也可以读取wtmp文件, 默认查询utmp
who -aH /var/log/wtmp  //查看wtmp文件
who -rH  //查看当前运行级别
who -q  //查看登录用户和用户数

7. w
查看当前登录系统的用户信息及用户当前的进程
w的信息来自两个文件: 用户登录信息来自/var/run/utmp, 进程信息来自/proc/

8. users
显示当前正在登录系统的用户名
默认读取/var/run/utmp, 也可以指定通用相关文件/var/log/wtmp

9. utmpdump
用于转储二进制日志文件到文本格式的文件以便查看, 也可以修改二进制文件
包括/var/run/utmp, /var/log/wtmp, /var/log/btmp
修改文件实际就是抹除系统记录, 所以一定要设置好权限, 防止非法入侵

//导出文件信息
 utmpdump /var/log/utmp > tmp_output.txt
//导入到源文件
 utmpdump -r tmp_output.txt > /var/log/utmp

10. 踢出已登录用户
pkill -KILL -t pts/0
</pre>
