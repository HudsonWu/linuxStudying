# 简介
crond是linux下用来周期性地执行某种任务或等待处理某些事件的一个守护进程

linux下的任务调度分为系统任务调度和用户任务调度
系统任务调度: 系统周期性所要执行的工作, 如写缓存数据到硬盘, 日志清理等
(/etc/crontab文件是系统任务调度的配置文件)
用户任务调度: 用户定期要执行的工作, 比如用户数据备份, 定时邮件提醒等
(所有用户定义的crontab文件都保存在/var/spool/cron目录, 文件名与用户名一致)

/etc/cron.deny: 该文件所列用户不允许使用crontab命令
/etc/cron.allow: 该文件所列用户允许使用crontab命令

# 安装
yum install vixie-cron  //cron的主程序
yum install crontabs  //用来安装, 卸载, 或列举用来驱动cron守护进程表格的程序

# 使用
特殊字符:
* : 代表所有可能的值
, : 用逗号指定一个列表范围, 如 1,2,3
- : 表示一个整数范围, 如 2-6
/ : 指定时间的间隔频率

1. 新增任务
  a. 在命令行输入crontab -e, 然后添加相应任务, wq保存退出
  b. 直接编辑/etc/crontab文件, 添加相应任务
2. 查看任务
crontab -l  //列出当前所有调度任务
crontab -l -u root  //列出root用户的所有调度任务
3. 删除任务
crontab -r  //从/var/spool/cron目录删除某个用户的crontab文件, 若不指定用户, 默认当前用户
crontab -i  //删除用户crontab文件时给出确认提示

5      *       *           *     *     ls         指定每小时的第5分钟执行一次ls命令
30     5       *           *     *     ls         指定每天的 5:30 执行ls命令
30     7       8           *     *     ls         指定每月8号的7:30分执行ls命令
30     5       8           6     *     ls         指定每年的6月8日5:30执行ls命令
30     5       8           6     *     ls         指定每年的6月8日5:30执行ls命令
30     6       *           *     0     ls         指定每星期日的6:30执行ls命令
30     3     10,20         *     *     ls         每月10号及20号的3:30执行ls命令
25     8-11    *           *     *     ls         每天8-11点的第25分钟执行ls命令
*/15   *       *           *     *     ls         每15分钟执行一次ls命令
30     6     */10          *     *     ls         每个月中,每隔10天6:30执行一次ls命令
22     4       *           *     *     root     run-parts     /etc/cron.daily
#每天4:22以root身份执行/etc/cron.daily目录中的所有可执行文件,run-parts参数表示,执行后面目录中的所有可执行文件

#每晚的21:30 重启apache
30 21 * * * /usr/local/etc/rc.d/lighttpd restart
#每月1、10、22日的4:45重启apache
45 4 1,10,22 * * /usr/local/etc/rc.d/lighttpd restart
#每周六、周日的1:10重启apache
10 1 * * 6,0 /usr/local/etc/rc.d/lighttpd restart
#每天18:00至23:00之间每隔30分钟重启apache
0,30 18-23 * * * /usr/local/etc/rc.d/lighttpd restart
#每星期六的11:00 pm重启apache
0 23 * * 6 /usr/local/etc/rc.d/lighttpd restart
#晚上11点到早上7点之间,每隔一小时重启apache
0 23-7/1 * * * /usr/local/etc/rc.d/lighttpd restart
#每一小时重启apache
0 */1 * * * /usr/local/etc/rc.d/lighttpd restart
#每月的4号与每周一到周三的11点重启apache
0 11 4 * mon-wed /usr/local/etc/rc.d/lighttpd restart
#一月一号的4点重启apache
0 4 1 jan * /usr/local/etc/rc.d/lighttpd restart
#每半小时同步一下时间
0/30 * * * * /usr/sbin/ntpdate 210.72.145.44

# 注意事项
1. 新创建的cron job， 不会马上执行, 至少要过2分钟才执行, 如果重启cron则马上执行
2. crontab中%有特殊含义, 表示换行, 如果需要使用的话必须进行转义\%
3. 注意清理系统用户的邮件日志
每条任务调度执行完毕, 系统都会将任务输出信息通过邮件的形式发送给当前系统用户, 可以将一些任务进行重定向处理
> 0 */3 * * * /usr/local/apache2/apachectl restart >/dev/null 2>&1
