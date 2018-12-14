# mount

用于加载文件系统到指定的加载点

此命令最常用于挂载cdrom, 使我们可以访问cdrom中的数据

使用mount命令将一个文件系统附着到当前文件系统层次结构中(根)

## 语法

```
mount [-t vfstype] [-o options] device dir

-t vfstype, 指定文件系统的类型, 通常不必指定, mount会自动选择正确的类型
光盘或光盘镜像: iso9660
DOS fat16文件系统: msdos
Windows 9x fat32文件系统: vfat
Windows NT ntfs文件系统: ntfs
Mount Windows文件网络共享: smbfs
UNIX(LINUX)文件网络共享: nfs

-o options, 主要用来描述设备或档案的挂接方式
loop, 用来把一个文件当成硬盘分区挂接上系统
ro, 采用只读方式挂接设备
rw, 采用读写方式挂接设备
iocharset, 指定访问文件系统所用字符集

其他选项:
-V, 显示程序版本
-l, 显示已加载的文件系统列表
-h, 显示帮助信息并退出
-v, 冗长模式, 输出指令执行的详细信息
-n, 加载没有写入文件/etc/mtab中的文件系统
-r, 将文件系统加载为只读模式
-a, 加载文件/etc/fstab中描述的所有文件系统

参数:
设备文件名, 指定要加载的文件系统对应的设备名
加载点, 指定加载点目录

mount -t auto /dev/cdrom /mnt/cdrom  //挂载cdrom
```

## 挂载ISO9600文件系统

```
CD's and DVDs are using ISO9660 filesystem. 
the aim of ISO9660 is to provide a data exchange standard between various operating systems.

1. detecting CD/DVD-ROM drives
wodim --devices
//if a wodim command is not available on your system make sure cdrecord package is installed on your system(apt-get install wodim OR apt-get install cdrecord)
OR
blkid (Locate Block device)

2. creating mount point
mkdir /media/cdrom

3. mount cdrom
mount -t iso9660 /dev/scd0 /media/cdrom

4. umount and eject CDROM
umount /dev/scd0
eject
OR(if you are having problems to umount your CDROM medium)
fuser -mk /dev/scd0
eject

5. testing for ISO9660 support
cat /proc/filesystems | grep iso9660
OR
lsmode | grep iso9660
```
