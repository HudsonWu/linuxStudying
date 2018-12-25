# pmap, 进程的内存使用

The pmap command reports the memory map of a process or processes

pmap提供了进程的内存映射, 用于显示一个或多个进程的内存状态, 其报告进程的地址空间和内存状态信息, 使用这个命令可以找出造成内存瓶颈的原因


pmap [options] pid [...]

选项:
```
-x, extended, 显示扩展格式
-X, 比-x更详细
-XX, show everything the kernel provides
-d, device, 显示设备格式
-q, quiet, 不显示header, footer行
-p, show full path
-V, 显示版本信息
```

输出结果分析:
```
Address: 内存开始地址
Kbytes: 占用内存的字节数（KB）
RSS: 保留内存的字节数（KB）
Dirty: 脏页的字节数（包括共享和私有的）（KB）
Mode: 内存的权限：read、write、execute、shared、private (写时复制)
Mapping: 占用内存的文件、或[anon]（分配的内存）、或[stack]（堆栈）
Offset: 文件偏移
Device: 设备名 (major:minor)

mapped, 内存映射所占空间大小
writeable/private, 私有地址空间大小
shared, 共享地址空间大小
```
