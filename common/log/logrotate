logrotate：可以自动对日志进行截断（或轮循）、压缩以及删除旧的日志文件
apt-get install logrotate cron
yum install logrotate crontabs
logrotate的配置文件是/etc/logrotate.conf，通常不需要进行更改
日志文件的轮循设置在独立的配置文件/etc/logrotate.d/目录下
1. 创建一个日志文件，填入10MB的随机比特流数据
  touch /var/log/log-file
  head -c 10M < /dev/urandom > /var/log/log-file
2. 配置logrotate来轮循该日志文件
  vim /etc/logrotate.d/log-file
  /var/log/log-file {
  monthly
  size=50M
  rotate 5
  dateext
  compress
  delaycompress
  missingok
  notifempty
  create 644 root root
  postrotate
      /usr/bin/killall -HUP rsyslogd
  endscript
  }
monthly 日志文件按月轮循，其他可用值为：'daily' 'weekly' 'yearly'
size 日志文件大小，容量到了就会自行切割
rotate 5 一次将存储5个归档日志，对于第六个归档，时间最久的归档将被删除
dateext 让旧日志文件以创建日期命名
compress 在轮循任务完成后，已轮循的归档将使用gzip进行压缩
delaycompress 总是与compress选项一起用，指示不要将最近的归档压缩，压缩将在下一次轮循周期进行
missingok 在日志轮循期间，任何错误将被忽略
notifempty 如果日志文件为空，轮循不会进行
create 644 root root 以指定的权限创建全新的日志文件
postrotate/endscript 在所有其他指令完成后，postrotate和endscripts里面指定的命令将被执行
这种情况下，rsyslogd进程将立即再次读取其配置并继续运行
3. 手动运行logrotate
logrotate /etc/logrotate.conf  为/etc/logrotate.d/下配置的所有日志调用logrotate
logrotate /etc/logrotate.d/log-file  为某个特定的配置调用logrotate
-d 以预演方式运行logrotate
-f 强制轮循日志文件
-v 提供详细输出
4. logrotate自身的日志存放于/var/lib/logrotate/status目录
logrotate -vf -s /var/log/logrotate-status /etc/logrotate.d/log-file
设置logrotate记录指定的文件
5. logrotate定时任务
logrotate需要的cron任务在安装是就自动创建了
cat /etc/cron.daily/logrotate
#!/bin/sh
# Clean non existent log file entries from status file
cd /var/lib/logrotate
test -e status || touch status
head -l status > status.clean
sed 's/"//g' status | while read logfile date
do
  [-e "$logfile"] && echo "\"$logfile\"$date"
done >> status.clean
mv status.clean status
 test -x /usr/sbin/logrotate || exit 0
 /usr/sbin/logrotate /etc/logrotate.conf
