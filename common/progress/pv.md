# pv, pipe viewer
显示当前在命令行执行的命令的进度信息, 管道查看器

要使用pv, 需要配合合适的选项, 把它放置在两个进程之间的管道, 
命令的标准输入将会通过标准输出传进来, 而进度会被输出到标准错误输出

## 选项
-p,  显示百分比
-t,  显示时间
-r,  传输速率
-e,  eta, 估计剩余时间
-n,  显示整数百分比, 每行显示一个数字
-L,  修改传输速率, 如 -L 2m, 限制传输速率为2MB/s

## 使用场景
1. 拷贝文件
> pv opencv_git.tar > /tmp/temp.tar
2. 压缩文件显示进度信息
> pv fnf.mkv | gzip > /var/fnf.mkv.gz
3. tar打包进度
> tar -czf - opencv_git/ | (pv -p --timer --rate --bytes > backup.tgz)
4. 字符一个个匀速在命令行中显示出来
> echo "Tecmint[dot]com is a community of linux nerds and geeks" | pv -qL 10
5. 用dd命令讲iso写入磁盘, pv实现进度条的显示
> pv -cN source < /path/cenots-7-x86_64-Everything.iso | dd of=/dev/disk2 bs=4m
