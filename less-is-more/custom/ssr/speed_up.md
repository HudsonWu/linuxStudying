# ssr加速

## centos开启bbr

1. yum系统更新(更新到7.3)
> yum update

2. 查看系统版本
> cat /etc/redhat-release

3. 安装elrepo并升级内核
```
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
yum --enablerepo=elrepo-kernel install kernel-ml -y
```

4. 更新grub文件并重启
```
egrep ^menuentry /etc/grub2.cfg | cut -f 2 -d \'
grub2-set-default 0
reboot
```

5. 查看内核是否已更换为4.9
> uname -r

6. 开启bbr
vi /etc/sysctl.cnf, 添加以下内容
```
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
```

7. 加载系统参数
> sysctl -p

8. 确定bbr已开启
```console
# sysctl net.ipv4.tcp_available_congestion_control
net.ipv4.tcp_available_congestion_control = bbr cubic reno
```
```console
# lsmod | grep bbr
tcp_bbr     16384  1
```

## centos6+ssr+锐速

1. 手动修改内核
锐速支持的CentOS6内核版本为2.6.32-504.3.3.el6.x86_64
```
uname -r  //查看系统内核版本
rpm -ivh http://xz.wn789.com/CentOSkernel/kernel-firmware-2.6.32-504.3.3.el6.noarch.rpm
rpm -ivh http://xz.wn789.com/CentOSkernel/kernel-2.6.32-504.3.3.el6.x86_64.rpm --force  //修改内核
rpm -qa | grep kernel  //查看是否安装成功
```
重启vps

2. 安装锐速破解版
```sh
wget -N --no-check-certificate https://raw.githubusercontent.com/wn789/serverspeeder/master/serverspeeder.sh  //下载一键安装脚本
chmod +x serverspeeder.sh  //赋予脚本可执行权限
bash serverspeeder.sh  //执行脚本
```

3. 锐速常用命令
```sh
service serverSpeeder start #启动
service serverSpeeder stop #停止
service serverSpeeder reload #重新加载配置
service serverSpeeder restart #重启
service serverSpeeder status #状态
service serverSpeeder stats #统计
service serverSpeeder renewLic #更新许可文件
service serverSpeeder update #更新
chattr -i /serverspeeder/etc/apx* && /serverspeeder/bin/serverSpeeder.sh uninstall -f #卸载
```
