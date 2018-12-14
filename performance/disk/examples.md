# 挂载

将一个文件系统与一个存储设备关联起来的过程称为挂载

## 挂接光盘镜像文件

<pre>
1. 将当前光驱里的光盘制作成光盘镜像文件
cp /dev/cdrom /home/someone/mydisk.iso
或者
dd if=/dev/cdrom of=/home/someone/mydisk.iso
2. 将文件和目录制作成光盘镜像文件
mkisofs -r -J -V mydisk -o /home/someone/mydisk.iso /home/someone/mydir
//将mydir目录下所有的目录和文件制作成光盘镜像文件, 卷标为mydisk
3. 光盘镜像文件的挂接
mkdir /mnt/vcdrom  //建立一个目录用作挂接点
mount -o loop -t iso9660 /home/someone/mydisk.iso /mnt/vcdrom
</pre>

## 挂接移动硬盘

<pre>
对Linux系统而言, USB接口的移动硬盘是当做SCSI设备对待的
1. 查看系统的硬盘和硬盘分区情况
fdisk -l
或者
more /proc/partitions
2. 挂接
mkdir -p /mnt/usbhd1 /mnt/usbhd2
//对ntfs格式的磁盘分区使用-t ntfs参数
mount -t ntfs /dev/sdc1 /mnt/usbhd1
//对fat32格式的磁盘分区使用-t vfat参数
mount -t vfat /dev/sdc5 /mnt/usbhd2
//若汉字文件名显示为乱码或不显示
mount -t ntfs -o iocharset=cp936 /dev/sdc1 /mnt/usbhd1
mount -t vfat -o iocharset=cp936 /dev/sdc5 /mnt/usbhd2
//使用fdisk分区命令和mkfs文件系统创建命令可以将移动硬盘的分区
//制作成linux系统所特有的ext2, ext3格式
mount /dev/sdc1 /mnt/usbhd1
</pre>

## 挂接Windows文件共享
<pre>
//windows网络共享的核心是SMB/CIFS, 在linux下要挂接的话, 必须安装和使用samba软件包
mkdir -p /mnt/samba
mount -t smbfs -o username=administrator,password=123456 //10.140.133.23/c$ /mnt/samba
</pre>

## 挂接UNIX系统NFS文件共享
### linux系统NFS服务端配置方法
<pre>
NFS, 网络文件系统
1. 修改/etc/exports, 增加共享目录
```
/export/home/someone 10.140.133.23(rw)
/export/home/someone1 *(rw)
/export/home/someone2 linux-client(rw)
```
/export/home/目录下的someone, someone1, someone2是准备共享的目录
10.140.133.23, *, linux-client是被允许挂接此共享的IP地址或主机名
2. 启动与停止NFS服务
/etc/rc.d/init.d/portmap start
/etc/rc.d/init.d/nfs start
/etc/rc.d/init.d/nfs stop
若修改/etc/exports文件增加新的共享, 应先停止NFS服务
使用命令exportfs -rv
</pre>
### linux客户端挂接其他linux或unix系统的NFS共享
```
mkdir -p /mnt/nfs
mount -t nfs -o rw 10.140.133.9:/export/home/somenone /mnt/nfs
```
