# RAID, 独立磁盘冗余阵列

RAID, Redundant Array of Independent Disks, 是目前商用服务器常见的磁盘管理技术

简单地说, RAID是一种由多块独立的硬盘按一定的方式组合起来的阵列, 可以使用小的便宜的磁盘代替大的昂贵的磁盘

RAID按照组合方式的不同可以分为不同的等级, 但是这些级别没有优劣之分, 仅仅代表着不同的组合方式

常见的组合方式有RAID0(条带), RAID1(镜像), RAID5(轮流校验码), RAID0+1(条带+镜像), RAID1+0(镜像+条带), JBOD(磁盘组)

## 基本作用

1. 数据冗余: 把数据的校验信息存放在冗余的磁盘中, 在某些磁盘数据损坏时, 能从其他未损坏的磁盘中, 重新构建数据
2. 性能提升: RAID能把多块独立的磁盘组成磁盘阵列, 通过把数据切成分片的方式, 使得读/写数据能走多块磁盘, 从而提升性能

## 各级RAID的基本原理

根据RAID的冗余信息程度, 切分数据的方式等不同, 可以把RAID分成不同的级别

一般地, RAID0容忍的坏盘数为0, 风险太大, 一般不常用; RAID1的信息冗余量很多, 适合于对信息安全要求很高并且预算充足的场景; RAID2的控制器比较复杂, 一般不常用; RAID3和RAID4由于写入性能差, 也不常用; RAID5由于读写性能, 能容忍的坏盘数都比较均衡, 因此, 一般工业街经常使用RAID5; RAID6对于坏盘数容忍度较高, 适合于对信息安全比较高的场景

### RAID0的基本原理

RAID0设计的目标是为了提升读写性能, 但并不带数据冗余信息
```
 A1       A2
 A3       A4
 A5       A6
 A7       A8

Disk0     Disk1
```
RAID0会把数据切成块, 分别存储在N个磁盘上, 当读数据时, 如果要读的数据块比较大, 分布在多磁盘上, 那么能同时从多块盘读数据; 当写数据时, 如果要写的数据块比较大, 分布在多块磁盘上, 那么同时能从多块盘写数据

因为数据分布在多块盘上, 当某块磁盘损坏时, 整个RAID系统就不可用了

N块盘的RAID0的特性:
+ 读性能最好情况下是单块盘的N倍
+ 写性能最好情况下是单块盘的N倍
+ 空间利用率为100%
+ 不具有冗余信息, 任何一块磁盘损坏, 整个RAID不可用

### RAID1的基本原理

RAID1的设计目标是为每份数据都提供一份或多份冗余数据
```
 A1       A1
 A2       A2
 A3       A3
 A4       A4

Disk0     Disk1
```
RAID1中一个磁盘都有一个或多个冗余的镜像盘, 所有磁盘的数据是一模一样的

RAID1读数据时, 可以利用所有数据盘的带宽; 写数据时, 要同时写入数据盘和镜像盘, 因此, 需要等待最慢的磁盘写完成, 写操作才完成, 因此, 写性能跟最慢的磁盘相当

N块盘的RAID1特性:
+ 读性能最好情况下是原来的N倍
+ 写性能跟最慢的磁盘相当
+ 空间利用率1/N
+ N块盘, 坏掉N-1块, RAID还能正常使用

### RAID2的基本原理

RAID2的设计目标在RAID0级别的基础上, 加了海明纠错码
```
 A1   A2   A3   A4   A(p1)   A(p2)   A(p3)
 B1   B2   B3   B4   B(p1)   B(p2)   B(p3)
 C1   C2   C3   C4   C(p1)   C(p2)   C(p3)
 D1   D2   D3   D4   D(p1)   D(p2)   D(p3)

Disk0  Disk1  Disk2  Disk3  Disk4  Disk5  Disk6
```
如上, 前面4个盘是数据盘, 后面3个盘是纠错码, RAID2读数据时, 能同时使用多个数据盘的带宽; RAID2写数据时, 除了写数据, 还需要写校验盘, 写性能会有下降

N块盘的RAID2特性:
+ 读性能不到原来的N倍, 因为还有一部分是校验盘
+ 写性能会有下降, 受限于校验盘的数量
+ 空间利用率小于100%, 海明纠错码需要的冗余盘一般比数据盘的数量少
+ 根据海明纠错码位数的不同, 能容忍的坏盘数不同

### RAID3的基本原理

RAID3是把数据按照字节分别存在不同的磁盘中, 并且最后一个磁盘提供纠错冗余
```
 A1   A2   A3   A(p(1-3))
 A4   A5   A6   A(p(4-6))
 B1   B2   B3   B(p(1-3))
 B4   B5   B6   B(p(4-6))

Disk0 Disk1 Disk2 Disk3
```
如上, 由于按照字节切分数据, 读数据时, 一定会同时从多个盘读数据, 可以利用所有数据盘的带宽; 写数据时, 也会利用所有磁盘的带宽, 但所有的写校验数据都会在一个盘, 写性能主要受限于校验盘

N块盘的RAID3特性:
+ 读性能是N-1倍, 其中一块盘是校验盘
+ 写性能受限于校验盘的写性能
+ 空间利用率为(N-1)/N
+ 坏掉一块盘, RAID还能正常工作

### RAID4

RAID4是把数据按照分块分别存在不同的磁盘中, 并且最后一个磁盘提供纠错冗余
```
A1   A2   A3   A(p)
B1   B2   B3   B(p)
C1   C2   C3   C(p)
D1   D2   D3   D(p)

Disk0 Disk1 Disk2 Disk3
```
如上, 读数据时, 当数据分布在多块盘时, 能够利用多块数据盘的带宽; 写数据时, 如果数据分布在多块盘时, 能利用所有磁盘带宽, 但写校验数据只能在一块盘上, 写性能受限于校验盘

N块盘的RAID4特性:
+ 读性能是N-1倍, 其中一块是校验盘
+ 写性能受限于校验盘的写性能
+ 空间利用率为(N-1)/N
+ 坏掉一块盘, RAID还能正常工作

### RAID5

RAID5是把数据块按照分块分别存在不同的磁盘中, 并且冗余信息也会分块分布在多块磁盘中
```
 A1   A2   A3   A(p)
 B1   B2   B(p)   B3
 C1   C(p)   C2   C3
 D(p)   D1   D2   D3

Disk0 Disk1 Disk2 Disk3
```
如上, 读数据时, 当数据分布在多块盘时, 能够利用多块数据盘的带宽; 写数据时, 如果数据分布在多块盘时, 能利用所有数据盘带宽, 同时写校验数据也分散在多块盘上, 但因为要额外写入校验数据, 写数据性能略微有所下降

N块盘的RAID5特性:
+ 读性能是N倍
+ 写性能略微弱于RAID0
+ 空间利用率为(N-1)/N
+ 坏掉一块盘, RAID还能正常工作

### RAID6

RAID6是把数据块按照分块分别存在不同的磁盘中, 并且冗余信息为两份奇偶校验码, 分布在多块磁盘中
```
A1   A2   A3   A(p)   A(q)
B1   B2   B(p)   B(q)   B3
C1   C(p)   C(q)   C2   C3
D(p)   D(q)   D1   D2   D3
E(q)   E1   E2   E3   E(p)

Disk0 Disk1 Disk2 Disk3 Disk4
```
读数据时, 当数据分布在多块盘时, 能够利用多块数据盘的带宽; 写数据时, 如果数据分布在多块盘时, 能利用多块数据盘带宽, 同时写校验数据也分散在多块盘中, 但因为要额外写入两份校验数据, 写数据性能略微下降

N块盘的RAID6特性:
+ 读性能是N倍
+ 写性能略微弱于RAID0
+ 空间利用率为(N-2)/N
+ 坏掉两块盘, RAID还能正常工作

