# fio用法

> fio分顺序读, 随机读, 顺序写, 随机写, 混合随机读写模式

## 参数

```
filename, 指定文件/设备的名称, 可以通过冒号分割同时指定多个文件, 如filename=/dev/sda:/dev/sdb
directory, 设置filename的路径前缀, 一般为测试硬盘挂载目录的地址
name, 指定job的名字, 在命令行中表示新启动一个job
direct, bool类型, 设置为true(1), 表示不使用io buffer
ioengine, I/O引擎, 默认是sync同步阻塞I/O, libaio是linux的native异步I/O
iodepth, 如果ioengine采用异步方式, 该参数表示一批提交保持的io单元数
rw, I/O模式, randwrite(随机写), randrw(随机读写)
bs, 单次io的块文件大小, 默认是4k
bsrange, 数据块大小范围, 如512-2048
size, 指定测试文件大小, 以每次bs大小的io进行测试
rwmixwrite, 混合读写模式下, 写占的百分比, 如30
numjobs, 指定job的克隆数(线程)
runtime, 指定在多少秒后停止进程, 如果未指定, fio将执行至指定的文件读写完全完成
time_based, 如果在runtime指定的时间还没到是文件读写完成, 将继续重复直到runtime时间结束
group_reporting, 当同时指定了numjobs时, 输出结果按组显示
lockmem, 只使用多少内存进行测试, 如1G
zero_buffers, 用0初始化系统buffer
nrfiles, 每个进程生成的文件数量
```

## 例子

```
# 顺序读
fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=1000 -group_reporting -name=mytest

# 顺序写
fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=1000 -group_reporting -name=mytest

# 随机读
fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=randread -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=1000 -group_reporting -name=mytest

# 随机写
fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=randwrite -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=1000 -group_reporting -name=mytest

# 混合随机读写
fio -filename=/dev/sda -direct=1 -iodepth 1 -thread -rw=randrw -rwmixread=70 -ioengine=psync -bs=16k -size=200G -numjobs=30 -runtime=100 -group_reporting -name=mytest -ioscheduler=noop

```
