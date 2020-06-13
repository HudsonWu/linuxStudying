# 增强功能

## 依赖

```
#安装依赖  
yum install -y gcc make perl  
#安装以下依赖之前，最好做好虚拟机备份，或者做好kernel版本保护  
yum install kernel-headers  
yum install kernel-devel  
yum install kernel  
reboot  
#做好版本保护（防止kernel版本意外更新），未测试  
#yum install yum-plugin-versionlock  
#yum versionlock add kernel-2.6.32-504.el6 kernel-devel-2.6.32-504.el6  
```

## 安装

```
#挂载光盘  
mount /dev/cdrom /mnt  
#安装VBoxLinuxAdditions  
/mnt/VBoxLinuxAdditions.run  
```
