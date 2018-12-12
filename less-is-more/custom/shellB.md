# 关闭系统的蜂鸣器

临时方案： sudo rmmod pcspkr
一劳永逸的方案: 
sudo echo "blacklist pcspkr" >> /etc/modprobe.d/blacklist (debian系列)
echo "alias pcspkr off" >> /etc/modprobe.conf (centos系列)

# 关闭linux响铃

1. 关闭shell中的响铃
整体关闭 vi /etc/inputrc, 添加:
> set bell-style=none  //关闭个人用户
> set bell-style none
> set bell-style off
2. 关闭vi和vim中的响铃
vi /etc/vimrc
vi /etc/virc
> set vb t_vb=
3. linux控制台下, 禁止终端响铃
setterm -blength 0
or
setterm -bfreq 10
2. X11下
xset b off
