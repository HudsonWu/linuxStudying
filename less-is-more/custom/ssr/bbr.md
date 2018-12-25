bbr
1. yum系统更新(更新到7.3)
> yum update
2. 查看系统版本
> cat /etc/redhat-release
3. 安装elrepo并升级内核
> rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org  
> rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm  
> yum --enablerepo=elrepo-kernel install kernel-ml -y  
4. 更新grub文件并重启
> egrep ^menuentry /etc/grub2.cfg | cut -f 2 -d \'  
> grub2-set-default 0  
> reboot  
5. 查看内核是否已更换为4.9
> uname -r
6. 开启bbr
vi /etc/sysctl.cnf, 添加以下内容
> net.core.default_qdisc = fq  
> net.ipv4.tcp_congestion_control = bbr 
7. 加载系统参数
> sysctl -p
8. 确定bbr已开启
a. 若
> sysctl net.ipv4.tcp_available_congestion_control  
返回
> net.ipv4.tcp_available_congestion_control = bbr cubic reno  
则成功
b. 若
> lsmod | grep bbr
返回形如
> tcp_bbr                16384  1  
则成功
