步骤:
1. 安装软件包
> yum install audit*.* -y
源码下载地址: http://people.redhat.com/sgrubb/audit/

2. 设置配置文件, 配置常用命令
audit安装后会生成 2 个配置文件: /etc/audit/auditd.conf和/etc/audit/audit.rules
/etc/audit/auditd.conf 是守护程序的默认配置文件
/etc/audit/audit.rules 是记录审计规则的文件, 首次安装audit后, 审计规则文件是空的

3. 添加审计规则

4. 启用audit守护进程并开始进行日志记录
> service auditd start  //启动
> service auditd stop   //停止
> service auditd restart  //重启
> service auditd reload  //重新加载auditd.conf的配置
> service auditd force-reload
> service auditd rotate  //旋转日志文件
> service auditd resume  //在推迟审核事件日志后重新开始
> service auditd status  //显示运行状态

5. 生成审计报表和搜索日志来周期性地分析数据
