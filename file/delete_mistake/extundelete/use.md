# extundelete

```
# 在将数据误删除后, 立刻要做的是卸载这块磁盘分区
umount /mnt/data

# 查询可恢复的数据信息
extundelete /dev/sdc1 --inode 2

# 恢复单个文件
# --restore-file后面指定的是恢复文件的路径, 这个路径是文件的相对路径
# 文件恢复成功后, 默认会在当前目录创建一个RECOVERED_FILES目录, 用于存放恢复出来的文件
extundelete /dev/sdc1 --restore-file file1

# 恢复单个目录
extundelete /dev/sdc1 --restore-directory /dir1

# 恢复所有被删除的文件和目录
extundelete /dev/sdc1 --restore-all

# 恢复某个时间段的数据
extundelete --after 1379156944 --restore-all /dev/sdc1
```
