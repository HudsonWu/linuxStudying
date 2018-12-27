# dd, 读取, 转换并输出数据

dd命令用于复制文件并对原文件的内容进行转换和格式化处理 <br/>
可从标准输入或文件中读取数据, 根据指定的格式来转换数据, 再输出到文件、设备或标准输出 <br/>

## 实例

1. 在linux下制作启动盘
```
dd if=boot.img of=/dev/fd0 bs=1440k
```

2. 将`testfile`文件中的所有英文字母转换为大写, 然后转成`testfile_1`文件
```
dd if=testfile of=testfile_1 conv=ucase
```

3. 有标准输入设备读入字符串, 将字符串转换成大写后, 输出到标准输出设备
```
dd conv=ucase
```
按组合键Ctrl+D退出, 转换成大写结果

4. 创建一个50M的文件
```
dd if=/dev/zero of=test.log bs=1M count=50
```
/dev/zero是一个字符设备, 会不断返回0值字节(\0) <br/>
bs代表字节为单位的块大小, count代表被复制的块数 <br/>

## 数据备份和恢复

### 整盘数据备份和恢复

```
备份:
dd if=/dev/hdx of=/dev/hdy  //将/dev/hdx整盘备份到/dev/hdy
dd if=/dev/hdx of=/path/to/image  //将/dev/hdx整盘备份到指定路径的image文件
dd if=/dev/hdx | gzip > /path/to/image.gz  //备份/dev/hdx全盘数据, 并利用gzip压缩

恢复:
dd if=/path/to/image of=/dev/hdx
gzip -dc /path/to/image.gz | dd of=/dev/hdx
```

### 利用netcat远程备份

```
//在源主机上执行命令备份/dev/hda
dd if=/dev/hda bs=16065b | netcat 192.168.0.2 1234

//在目的主机上执行命令接收数据并写入/dev/hdc
netcat -l -p 1234 | dd of=/dev/hdc bs=16065b

netcat -l -p 1234 | bzip2 > partition.im
```

### 备份MBR

```
//备份磁盘开始的512Byte大小的MBR信息到指定文件
dd if=/dev/hdx of=/path/to/image count=1 bs=512

//降备份的MBR信息写到磁盘开始部分
dd if=/path/to/image of=/dev/hdx
```

### 其他操作

```
//将软驱数据备份到当前目录的disk.img文件
dd if=/dev/fd0 of=disk.img count=1 bs=1440k

//拷贝内存资料到硬盘
dd if=/dev/mem of=/root/mem.bin bs=1024

//从光盘拷贝iso镜像
dd if=/dev/cdrom of=/root/cd.iso

//销毁磁盘数据
dd if=/dev/urandom of=/dev/hda1
利用随机数据填充硬盘, 在某些场合可以用来销毁数据
执行此操作后, /dev/hda1将无法挂载, 创建和拷贝操作无法执行
```

### 增加swap分区文件大小

```
//创建一个足够大的文件(此处为256M)
dd if=/dev/zero of=/swapfile bs=1024 count=262144
//把这个文件变成swap文件
mkswap /swapfile
//启用这个swap文件
swapon /swapfile
//开机自动加载swap文件(在/etc/fstab文件中增加一行)
/swapfile swap swap defaults 0 0
```

## 磁盘管理

1. 得到最恰当的block size
```
dd if=/dev/zero bs=1024 count=1000000 of=/root/1Gb.file
dd if=/dev/zero bs=2048 count=500000 of=/root/1Gb.file
dd if=/dev/zero bs=4096 count=250000 of=/root/1Gb.file
dd if=/dev/zero bs=8192 count=125000 of=/root/1Gb.file
```
通过比较dd指令输出中所显示的命令执行时间, 即可确定系统最佳的block size大小

2. 测试硬盘读写速度
```
dd if=/root/1Gb.file bs=64k | dd of=/dev/null
dd if=/dev/zero of=/root/1Gb.file bs=1024 count=1000000
```
通过上两个命令输出的执行时间, 可以计算出磁盘的读/写速度

3. 修复硬盘
```
dd if=/dev/sda of=/dev/sda
当硬盘较长时间放置不使用时, 磁盘上会产生magnetic flux point, 
当磁头读到这些区域时会遇到困难, 可能导致I/O错误, 
当这种情况影响到硬盘的第一个扇区时, 可能导致硬盘报废, 
上面的命令可能使这些数据起死回生, 且这个过程是安全, 高效的
```

## 参数说明

+ if=文件名, 输入文件名, 默认为标准输入
+ of=文件名, 输出文件名, 默认为标准输出
+ ibs=bytes, 一次读入bytes个字节, 即指定一个读入块, 大小为bytes个字节
+ obs=bytes, 一次输出bytes个字节, 即指定一个输出块, 大小为bytes个字节
+ bs=bytes, 同时设置读入/输出的块大小为bytes个字节
+ cbs=bytes, 一次转换bytes个字节, 即指定转换缓冲区大小
+ skip=blocks, 从输入文件开头跳过blocks个块后再开始复制
+ seek=blocks, 从输出文件开头跳过blocks个块后再开始复制
+ count=blocks, 仅拷贝blocks个块, 块大小等于ibs指定的字节数
+ conv=<关键字>
    + conversion, 用指定的参数转换文件
    + ascii, 转换ebcdic为ascii
    + ebcdic, 转换ascii为ebcdic
    + ibm, 转换ascii为alternate ebcdic
    + block, 把每一行转换为长度为cbs, 不足部分用空格填充
    + unblock, 使每一行的长度都为cbs, 不足部分用空格填充
    + lcase, 把大写字符转换为小写字符
    + ucase, 把小写字符转换为大写字符
    + swab, 交换输入的每对字节
    + noerror, 出错时不停止
    + notrunc, 不截短输出文件
    + sync, 将每个输入块填充到ibs个字节, 不足部分用空(NUL)字符补齐
+ --help, 显示帮助信息
+ --version, 显示版本信息

块大小可以使用的计量单位表: <br/>
|      :size:     | :code: |
|    ----------   | ------ |
|    字节(1B)     |    c   |
|    字节(2B)     |    w   |
|    块(512B)     |    b   |
| 千字节(1024B)   |    K   |
| 兆字节(1024KB)  |    M   |
| 吉字节(1024MB)  |    G   |

