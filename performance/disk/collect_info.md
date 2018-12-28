# Collect hardware information

## lsblk, 列出可用块设备信息

lsblk命令用于列出所有可用块设备的信息, 而且还能显示他们之间的依赖关系, 但不会列出RAM盘的信息. 块设备有硬盘, 闪存盘, cd-ROM等

lsblk命令包含在util-linux-ng包中, 现在改包改名为util-linux, 这个包还包含几个其他工具, 如dmesg
```
yum install util-linux-ng
```

选项
```
-a, --all    显示所有设备
-b, --bytes    以bytes方式显示设备大小
-d, --nodeps    不显示slaves或holders
-D, --discard    print discard capabilities
-e, --exclude <list>    排除设备(default: RAM disks)
-f, --fs    显示文件系统信息
-h, --help    显示帮助信息
-i, --ascii    use ascii characters only
-m, --perms    显示权限信息
-l, --list    使用列表格式显示
-n, --noheadings    不显示标题
-o, --output <list>    输出列
-p, --pairs    使用"key=value"格式显示
-r, --raw    使用原是格式显示
-t, --topology    显示拓扑结构信息
```

lsblk命令默认情况下将以树状列出所有块设备
```console
# lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   40G  0 disk 
├─sda1            8:1    0  500M  0 part /boot
└─sda2            8:2    0 39.5G  0 part 
  ├─centos-swap 253:0    0    1G  0 lvm  [SWAP]
  └─centos-root 253:1    0 38.5G  0 lvm  /
sr0              11:0    1 55.3M  0 rom  
```

+ NAME, 块设备名
+ MAJ:MIN, 主要和次要设备号
+ RM, 是否是可移动设备
+ SIZE, 设备的容量大小
+ RO, 设备是否为只读
+ TYPE, 块设备是否是磁盘或磁盘上的一个分区
+ MOUNTPOINT, 设备挂载的挂载点

```
lsblk -a  //默认不会列出空设备, 使用-a选项可以查看空设备
lsblk -m  //列出一个特定设备的拥有关系, 也可以列出组合模式
lsblk -b /dev/sda  //获取指定设备
lsblk -nl  //一列表格式列出, 且不显示标题
lsblk -S  //获取SCSI设备列表
lsblk -s  //逆序, 将设备和分区的组织关系逆转过来显示
```

## lsusb, 显示本机的USB设备列表及详细信息

USB, 通用串行总线(Universal Serial Bus), 被设计成为连接计算机外设的标准, 如键盘、鼠标、打印机、数码相机、便携式媒体播放器、磁盘和网络设配器等

lsusb, 显示系统中以及连接到系统的USB总线信息的工具

lsusb命令是一个学习USB驱动开发, 认识USB设备的助手

选项
```
-v    显示USB设备的详细信息
-s <总线: 设备号>    仅显示指定的总线和(或)设备号的设备
-d <厂商: 产品>    仅显示指定厂商和产品编号的设备
-t    以树状机构显示usb设备的层次
-V    显示命令的版本信息
```

```console
# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 002: ID 0a5c:217f Broadcom Corp. Bluetooth Controller
```

+ Bus 008: 指明设备连接到哪(哪条总线)
+ Device 002: 表明这是连接到总线上的第二台设备
+ ID: 设备的ID
+ Broadcom Corp. Bluetooth Controller: 生产商名字和设备名

```
find /dev/bus  #找出连接了多少usb设备
lsusb -D /dev/bus/usb/008/002  #打印特定设备的详细信息
lsusb -v | grep -Ei '(idVendor|Mass\ Storage)'  #找出大容量存储设备
lsusb -t  #以树层级结构输出USB设备
```

## lsscsi, print SCSI devices information

```
apt-get install lsscsi
yum install lsscsi

lsscsi
lsscsi -s  #show device sizes
```

## hdparm, print information about SATA devices

To pring information about device geometry interms of cylinders, heads, sectors, size and the starting offset of the device, use the -g option
```
hdparm /dev/sda1
hdparm -g /dev/sda1
```
