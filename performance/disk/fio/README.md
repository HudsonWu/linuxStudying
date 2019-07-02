# fio, Flexible IO Tester, 简单好用的性能测试工具

fio是测试IOPS非常好的工具, 用来对硬件进行压力测试和验证, 支持13种不同的I/O引擎, 包括: sync, mmap, libaio, posixaio, SG v3, splice, null, network, syslet, guasi, solarisaio等

```
# yum 安装
yum install libaio-devel fio
# 手动安装
yum install libaio-devel
wget http://brick.kernel.dk/snaps/fio-3.14.tar.gz
tar -zxvf fio-3.14.tar.gz
cd fio-3.14
make && make install
```

> 性能测试建议直接通过写裸盘的方式进行测试, 会得到较为真实的数据。但直接测试裸盘会破坏文件系统结构, 导致数据丢失, 请在测试前确认磁盘中数据已备份

## 使用

+ bw: 磁盘的吞吐量, 这个是顺序读写考察的重点
  + 常用单位为MB/s
  + 适用场景: 大文件拷贝(如视频音乐)
+ iops: 磁盘的每秒读写次数, 这个是随机读写考察的重点
  + 常用单位为次
  + 适用场景: 操作系统运行, 软件运行, 数据库

```
# 测试混合随机读写
fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=randrw -rwmixread=70 -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=100 -group_reporting -name=mytest1
fio -filename=$filename -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
```
