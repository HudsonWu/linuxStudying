# lspci, 显示所有PCI总线信息以及PCI设备信息

## PCI

PCI, Peripheral Component Interconnect, 外围器件互联, 是由PCISIG(PCI Special Interest Group)推出的一种局部并行总线标准

PCI总线是一种树形结构, 并且独立于CPU总线, 可以和CPU总线并行操作. PCI总线上可以挂接PCI设备和PCI桥片, PCI总线上只允许有一个PCI主设备, 其他的均为PCI从设备, 而且读写操作只能在主从设备之间进行, 从设备之间的数据交换需要通过主设备中转

PCI总线作为处理器系统的局部总线, 主要目的是为了连接外部设备, 而不是作为处理器的系统总线连接Cache和主存储器

## lspci

lspci是一个用来显示系统中所有PCI总线设备或连接到该总线上的所有设备的工具

```
yum install pciutils  #安装
lspci  #显示目前的硬件设备
lspci -v  #查看一般详细信息
lspci -s 02:02.0 -vv  #查看网卡详细信息, -s后面接的是每个设备的总线、插槽与相关函数功能
```

用到的文件
+ /usr/share/hwdata/pci.ids
    + 所有已知PCI ID的清单(厂商, 设备名, 类, 子类)
+ /proc/bus/pci
    + PCI总线配置空间的接口, 包含每个总线(per-bus)的子目录以及每个设备卡(per-card)的配置空间档案, 还有一个devices档案, 包含所有PCI设备的列表

选项
```
-n, 以数字方式显示PCI厂商和设备代码
-t, 以树状结构显示PCI设备的层次关系, 包括所有总线、桥、设备以及它们之间的连接
-b, 以总线为中心的视图
-d, 仅显示给定厂商和设备的信息
-s, 仅显示指定总线、插槽上的设备和设备上的功能块信息
-i, 指定PCI编号列表文件, 而不使用默认的文件
-m: 以机器可读方式显示PCI设备信息
```

