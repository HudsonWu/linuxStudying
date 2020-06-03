# linux 恢复误删除的文件或者目录

对于误删除文件还原分为两种情况:
+ 删除以后进程存在删除信息
+ 删除以后进程都找不到, 只有借助于工具还原

## 误删除文件进程还在的情况

```sh
# # 这种一般是有活动的进程存在持续标准输入或输出
# # 文件被删除后, 进程PID依旧存在, 这也是有些服务器删除文件但是磁盘不释放的原因
# lsof | grep deletefile  # 查看删除的文件进程是否还存在
# cd /proc/pid/fd/  # 进入进程目录, 如/proc/21796/fd
# cp /proc/pid/fd/1 /path/deletefile  # 恢复文件
```

## 误删除的文件进程已经不存在, 借助于工具还原

+ [extundelete] (/common/file/delete_mistake/extundelete.md)
