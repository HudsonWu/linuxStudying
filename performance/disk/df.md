# df, disk filesystem

检查文件系统的磁盘空间占用情况

## 选项

```
-a, 全部文件系统, 包括虚拟文件系统
-h, 方便阅读, GB
-T, 显示指定文件系统的磁盘信息
-k, KB
-m, MB
-i, 显示inode信息
-t, 显示指定文件系统类型的磁盘信息
-x, 不显示指定文件系统类型的磁盘信息
```

## 实例

```sh
df -hT /home
df -t ext3
df -x ext3
```
