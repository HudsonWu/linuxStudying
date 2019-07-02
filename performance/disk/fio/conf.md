# 将参数写进配置文件

## fio.conf

```
[global]
ioengine=libaio
direct=1
thread=1
norandommap=1
randrepeat=0
runtime=60
ramp_time=6
size=1g
directory=/path/to/test

[read4k-rand]
stonewall
group_reporting
bs=4k
rw=randread
numjobs=8
iodepth=32

[read64k-seq]
stonewall
group_reporting
bs=64k
rw=read
numjobs=4
iodepth=8

[write4k-rand]
stonewall
group_reporting
bs=4k
rw=randwrite
numjobs=2
iodepth=4

[write64k-seq]
stonewall
group_reporting
bs=64k
rw=write
numjobs=2
iodepth=4
```

```
[global]
ioengine=libaio
iodepth=128
time_based
direct=1
thread=1
group_reporting
randrepeat=0
norandommap
numjobs=32
timeout=6000
runtime=120

[randread-4k]
rw=randread
bs=4k
filename=/dev/sdb   # 注：/dev/sdb 是目标测试磁盘的设备名称
rwmixread=100
stonewall

[randwrite-4k]
rw=randwrite
bs=4k
filename=/dev/sdb
stonewall

[read-512k]
rw=read
bs=512k
filename=/dev/sdb
stonewall

[write-512k]
rw=write
bs=512k
filename=/dev/sdb
stonewall
```

使用方法
```
fio fio.conf
```
