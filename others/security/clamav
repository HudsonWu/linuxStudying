# ClamAV 病毒查杀工具

+ 安装
<pre>
yum install epel-release
yum install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd -y
</pre>

+ 配置
<pre>
//移除Example字符
sed -i -e "s/^Example/#Example/" /etc/freshclam.conf
sed -i -e "s/^Example/#Example/" /etc/clamd.d/scan.conf
</pre>

+ 手动更新病毒库
> freshclam

+ clamdscan扫描, 需要开启服务才能使用, 速度快, 不用带-r， 默认会递归扫描子目录
> clamdscan /usr

+ clamscan扫描, 不需要开始服务就能使用, 速度慢
> //扫描/root及子目录并自动删除病毒, -r选项表示包含子目录
> clamscan -r /root --remove -l /var/log/clamscan.log

+ 扫描后只显示找到的病毒
> //-i只显示发现的病毒文件, --no-summary不显示统计信息
> clamscan --no-summary -ri /tmp
