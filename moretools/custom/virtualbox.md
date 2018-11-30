kali LINUX 更新源
1. 判断kali版本
lsb_release -a
2. 添加更新源 /etc/apt/source.list
3. apt-get clean && apt-get update && apt-get upgrade && apt-get dist-upgrade
(apt-get update --fix-missing)
4. 更新内核头
apt-get install linux-headers-$(uname -r)
手动更新
https://http.kali.org/kali/pool/main/l/linux/
linux-kbuild-4.12_4.12.13-1kali2_amd64.deb
linux-headers-4.12.0-kali2-common_4.12.13-1kali2_all.deb
linux-headers-4.12.0-kali2-amd64_4.12.13-1kali2_amd64.deb
dpkg -i
5. 验证头文件是否成功安装
dpkg-query -s linux-headers-$(uname -r)

VirtualBox增强功能
1. 在线安装
apt-get install -y virtualbox-guest-x11
reboot
2. 自带包安装
apt-get update && apt-get install -y linux-header-$(uname -r)
cp /media/cd-rom/VBoxLinuxAdditions.run /root/
chmod 755 /root/VBoxLinuxAdditions.run
cd /root
./VBoxLinuxAdditions.run

开启系统的路由转发功能
vi /etc/sysctl.conf
net.ipv4.ip_forward=1