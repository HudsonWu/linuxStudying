# 一些常用命令集

## du与df统计不一致的查找方案

```
# df命令查看
df -h

# du命令查看
du -h --max-depth=1 /var/sdb1/dir | sort -n -k1
```

硬盘空间不一致的原因一般是因为删除的文件被其他程序引用，导致空间无法回收，解决方法就是找到引用文件的相关进程，然后停掉进程让空间回收即可。
```
# 查找引用已删除文件的进程
lsof -s | grep deleted | sort -nr -k7 | less

# 结束相关进程
kill 11566
```

## 实用小命令

```
# ls排序
ls -S -l
ls --sort=size *.avi
ls -l -S | sort -k 5 -n
```
