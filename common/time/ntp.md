# NTP (网络时间协议)

运行在传输层123端口的UDP协议, 它允许计算机通过网络同步准确时间

+ 安装

> yum install ntp

+ 访问NTP公共时间服务器池 <https://www.pool.ntp.org/en/>，找到所在国家NTP服务器列表
+ 编辑NTP守护进程的主配置文件, 替换服务器列表为所在国家列表

> server 0.cn.pool.ntp.org

+ 允许客户端和服务器同步时间, 添加下面一行到NTP配置文件, 
  + restrict语句控制允许哪些网络查询和同步时间
  + nomodify notrap语句意味着不允许你的客户端配置服务器或者作为同步时间的节点

> restrict 192.168.1.0 netmask 255.255.255.0 nomodify notrap

+ 日志文件

> logfile /var/log/ntp.log

+ 添加防火墙规则

> firewall-cmd --add-service=ntp --permanent

> firewall-cmd --reload

+ 启动NTP服务器

> systemctl start ntpd

+ 验证服务器时间同步

> ntpq -p

> date -R

+ 查询或和选择的服务器池同步
```
ntpdate -q 0.cn.pool.ntp.org 1.cn.pool.ntp.org
ntpdate 192.168.8.100  //测试时间同步是否成功, 本地ip
ntpdate -d 192.168.8.100  //查看时间同步过程
ntpstat  //查看时间同步状态
5 * * * * /usr/sbin/ntpdate 0.cn.pool.ntp.org \
    1.cn.pool.ntp.org >> /var/debug/ntpdate.log 2>&1
```