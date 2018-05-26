centos6+ssr+锐速
1. 手动修改内核
> uname -r  //查看系统内核版本
锐速支持的CentOS6内核版本为2.6.32-504.3.3.el6.x86_64
> rpm -ivh http://xz.wn789.com/CentOSkernel/kernel-firmware-2.6.32-504.3.3.el6.noarch.rpm
> rpm -ivh http://xz.wn789.com/CentOSkernel/kernel-2.6.32-504.3.3.el6.x86_64.rpm --force  //修改内核
> rpm -qa | grep kernel  //查看是否安装成功
重启vps
2. 安装锐速破解版
> wget -N --no-check-certificate https://raw.githubusercontent.com/wn789/serverspeeder/master/serverspeeder.sh  //下载一键安装脚本
> chmod +x serverspeeder.sh  //赋予脚本可执行权限
> bash serverspeeder.sh  //执行脚本
3. 锐速常用命令
service serverSpeeder start #启动
service serverSpeeder stop #停止
service serverSpeeder reload #重新加载配置
service serverSpeeder restart #重启
service serverSpeeder status #状态
service serverSpeeder stats #统计
service serverSpeeder renewLic #更新许可文件
service serverSpeeder update #更新
chattr -i /serverspeeder/etc/apx* && /serverspeeder/bin/serverSpeeder.sh uninstall -f #卸载
