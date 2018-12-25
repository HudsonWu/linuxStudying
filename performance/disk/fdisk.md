## fdisk

fixed disk or format disk<br/>
manipulate(操作) disk partition table<br/>
用于观察硬盘实体使用情况, 也可对硬盘分区<br/>

> fdisk /dev/sda <br/>
> fdisk -l  //查看所有磁盘分区<br/>
> fdisk -l /dev/sda <br/>
> fdisk -s /dev/sda2 <br/>

### 调整sd卡分区大小

> https://blog.csdn.net/qq_20480611/article/details/48657827 <br/>
<pre>
1. fdisk /dev/mmcblk0
交互式操作
(
p, 查看分区情况, 记住/dev/mmcblkop2的start值
d 2, 删除分区2
p, 查看分区情况
n, 加分区
p, 主分区
p, 查看分区情况
w, 执行分区操作
)
2. 重启
3. resize2fs /dev/mmcblk0p2, 修复分区
<pre>
