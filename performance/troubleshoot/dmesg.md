# dmesg, 显示开机信息

dmesg命令被用于检查和控制内核的环形缓冲区, kernel会将开机信息存储在ring buffer中, 可以利用dmesg来查看, 开机信息保存在/var/log/dmesg文件里, 可以从中获得诸如系统架构, cpu, 挂载的硬件, RAM等多个运行级别的大量系统信息


## 语法

dmesg [options...]

```
-C, --clear, Clear the ring buffer
-c, --read-clear, Clear the ring buffer contents after printing
-s <缓冲区大小>, 预设置为8196, 刚好等于ring buffer的大小
-n, 设置记录信息的层级
```

## 处理故障和收集系统信息的用法

1. 搜索包含特定字符串的被检测到的硬件

当计算机启动时, 系统内核将会被加载到内存中, 在加载的过程中会显示很多的信息, 在这些信息中可以看到内核检测硬件设备

```
dmesg | grep -in usb
dmesg | grep -in dma
dmesg | grep -in mem
```

2. 将dmesg内容输出到文件

```
dmesg > boot.msg
```

3. 清空dmesg缓冲区日志

```
dmesg -C
dmesg -c
```
该命令会清空dmesg环形缓冲区中的日志, 但依然可以查看存储在/var/log/dmesg文件中的日志

4. 实时监控dmesg日志输出

```
watch "dmesg | tail -20[C"
```
在系统dmesg记录实时更改或产生的情况下非常有用
