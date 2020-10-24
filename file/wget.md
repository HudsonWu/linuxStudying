# wget实用用法

```
# 下载目录下所有文件
## -r, 递归下载; -np, 不查找上层目录; -nH, 不保存文件到主机名目录
## --cut-dirs=3, url前3个目录不创建; -R, 排除某个文件
wget -r -np -nH --cut-dirs=3 -R index.html http://hostname/aaa/bbb/ccc/ddd/

```
