# swap, 实现虚拟内存的重要概念

swap就是把硬盘上一部分空间当做内存使用

> + swap out, 正在运行的程序会使用物理内存, 把没有使用的内存放到硬盘
> + swap in, 把硬盘swap部分的内存重新放到物理内存中

swap可以在逻辑上扩大内存空间, 但是会造成系统变慢, 因为硬盘读写速度很慢 <br/>
linux系统比较智能, 会把那些不怎么频繁使用的内存放到swap <br/>

## swap设置

可以在/etc/sysctl.conf里设置vm.swappiness参数<br/>
设置成vm.swappiness=10, 就是说当内存使用90%以上才会使用swap空间<br/>

## 释放linux的swap内存

有的时候, 内存会被缓存占用, 导致系统开始使用swap空间, 此时就需要清理下swap了<br/>

1. 先执行sync命令
```
sync  
```

sync命令可用来强制将内存缓冲区中的数据立即写入磁盘中<br/>

2. `drop_caches`
```
echo 3 > /proc/sys/vm/drop_caches  
```
此指令输入立即生效, 意在释放所有缓存

3. 关闭swap, 再开启swap
```
swapoff -a
swapon -a
```

## 新增和增加SWAP分区

目前红帽官方推荐的交换分区大小应当与系统物理内存大小保持线性比例关系, 不过在小于2GB物理内存的系统中, 交换分区大小应该设置为内存大小的两倍, 如果内存大小多于2GB, 交换分区大小应该是物理内存大小加上2GB. 其原因在于, 系统中的物理内存越大, 对于内存的负荷可能越大

实际上, 系统中交换分区的大小并不取决于物理内存的量, 而是取决于系统中内存的负荷, 

在装完linux系统之后, 建立swap分区有两种方法
1. 新建磁盘分区作为swap分区
2. 用文件作为swap分区

### 新建磁盘分区作为swap分区

1. swapoff -a  //停止所有的swap分区

2. 用fdisk命令对磁盘进行分区, 添加swap分区

新建分区, 在fdisk中用't'命令将新添的分区id改为82(linux swap类型), 最后用w将操作写入硬盘

3. mkswap /dev/sdb2  //格式化swap分区

4. swapon /dev/sdb2  //启动新的swap分区

5. 让系统启动时自动启用交换分区

编辑/etc/fstab, 加入`/dev/sdb2 swap swap defaults 0 0`

### 用文件作为swap分区

1. 创建要作为swap分区的文件, 增加1GB大小的交换分区
```
dd if=/dev/zero of=/var/swapfile bs=1M count=1024
```
2. 格式化为交换分区文件
```
mkswap /var/swapfile  //建立swap的文件系统
```
3. 启用交换分区文件
```
swapon /var/swapfile
```
4. 使系统开机时自启用, 在文件/etc/fstab中添加一行
```
/var/swapfile swap swap defaults 0 0
```

### 收回swap空间

```
swapoff /var/swapfile  //收回swap空间
rm /var/swapfile  //从文件系统中回收
```
