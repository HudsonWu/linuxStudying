# fallocate, preallocate or deallocate space to a file

`fallocate`是linux特有的系统调用, 并不符合POSIX标准, 为了兼容posix标准的`fallocate`, glibc专门做了一个`posix_fallocate`函数, 虽然从功能上实现了`fallocate`的基本功能, 但本质上它们是两回事: `fallocate`是文件系统层提供的实现, 它的很多特性必须得到文件系统底层的支持; 而`posix_fallocate`是在上层的实现, 就算文件系统底层不支持任何`fallocate`的操作, 也可以使用`posix_fallocate`

```
int fallocate(int fd, int mode, off_t offset, off_t len);
```

`fallocate`就是对fd所指向文件的offset+len区间做mode指定的操作

## fallocate上的5种mode

### Allocating disk space

这是默认的操作, 对应mode等于0, 它所做的工作是分配从offset开始到offset+len的一段空间, 这个是真的分配磁盘空间, 不是hole, 新分配的空间以0填充数据, 当然这个操作一般在offset+len大于现有文件长度时才会起到增加文件数据空间的作用

一般情况下新增加空间后文件的size也会随着调整, 但是有一个特殊情况, 就是当`FALLOC_FL_KEEP_SIZE`出现在mode中时, 在增加文件空间后不会改变文件的size, 这样的操作算是一种在文件结尾处的预分配, 对于后期的append写入操作有优化作用

### Deallocating file space

这个就是大名鼎鼎的punch hole操作, 相信在很多软件中都看到过这样的操作. 对应的mode是`FALLOC_FL_PUNCH_HOLE`, 从Linux 2.6.38开始由XFS首先支持这个操作, 后面ext4在3.0时也支持了这个操作, btrfs在3.7时做到支持. 从字面意思就可以明白punch hole就是“打洞”, 就像是在一张纸上戳出很多洞一样, 那些被戳掉的地方原来的内容就没了, 纸的实际面积就缩小了, 但是从整体上看这张纸还是那么大一张, 只是中间多了很多洞. 那么对这些洞的读操作就默认返回数据0(写操作会重新填充这些洞). 

跟上面的操作一样, 这个操作也可以和`FALLOC_FL_KEEP_SIZE`混用. 混用后的效果就是punch hole之后文件的size也不变. 这里还要说一下, 虽然不带`FALLOC_FL_KEEP_SIZE`时punch hole操作会导致文件size的减小, 但是我们最好不要在调用fallocate的punch hole操作后就认定size一定小多少. 没有这样的标准说一定这样, 而且将来实现reflink后, 对reflink文件的punch hole操作结果还不得而知. 

### Collapsing file space

大概从Linux 3.15开始ext4和XFS开始支持fallocate的collapse操作, 对应的mode是`FALLOC_FL_COLLAPSE_RANGE`. 对比上面的punch hole操作, 这个collapse操作不会留下空洞. 它相当于把一张白纸从A到B处撕下去, 然后把剩下的部分重新拼接起来组成一张新的白纸. 就是把offset到offset+len这段区域的数据丢掉, 然后把offset+len以后的数据移动到offset的位置, 整个offset+len后的文件数据往前移动. 

这里一定要和punch hole区分, punch hole之后, 读取offset+n(n < len)会读到0, 但是collapse之后读offset+n时就会读到原来offset+len+n位置的数据. 

collapse操作不能和包括`FALLOC_FL_KEEP_SIZE`在内的任何mode参数混用. 

### Zeroing file space

这个操作也是从Linux 3.15开始被部分文件系统支持, 对应的mode是`FALLOC_FL_ZERO_RANGE`. 这个操作比collapse操作更容易和punch hole混淆. 我们上面说punch hole就是把offset到offset+len这段空间删除, 但这段空间偏移量还保留在那里, 读的时候会读到0. 那么zero操作就比较复杂了, 对于像XFS来说zero操作就相当于把offset到offset+len这段区域变为unwritten extents. 说到unwritten extent还得解释什么时unwritten extent

简单来说unwritten extent就是把一段区域设置为“这里我还没有写, 这段数据现在是无效的, 先别让人看到这段数据”的模式, 在metadata中设置这样的标志就会把这段空间保护起来不让人看见, 而对这段空间的读操作就会返回数据0. 看效果和punch hole差不多, 共同点是读的时候都会返回0, 但区别还是有的, 至少一段没有的空间和一段在那只是不给你看的空间比起来后者写起来效果更快吧. 具体不同也要看不同文件系统的实现. (另: 在xfs上可以通过`xfs_bmap来查看punch hole和zero操作的不同, -p选项可以列出zero操作的unwritten extents, 而punch hole的地方会直接显示hole. )

zero操作也可以和`FALLOC_FL_KEEP_SIZE`混用, 混用的效果和上面punch hole的效果一样, 都是不改变文件大小. 

### Increasing file space

这是个比较新的操作, 从Linux 4.1开始被XFS实现, 4.2开始才在ext4上实现. 对应的mode是`FALLOC_FL_INSERT_RANGE`. insert顾名思义就是插入的意思, 那么这个mode就是插入一个hole. 在一个文件的中间offset位置上插入一个len长度的hole, 而原offset到offset+len区域的数据的偏移量向后移动len长度. 插入一个hole之后虽然没有实际分配新的磁盘空间, 但是由于增加了偏移量而让文件的size增大. 对hole区域的读操作还是返回0. 注意这个操作的offset不能超过文件的结尾. 

insert操作也可以和`FALLOC_FL_KEEP_SIZE`混用, 混用的效果还是不改变文件size. 

## fallocate 命令

fallocate -l 500MB file1

## Reference

<https://blog.csdn.net/ZR_Lang/article/details/51032815> 
<http://xfs.org/docs/xfsdocs-xml-dev/XFS_User_Guide/tmp/en-US/html/ch02s07.html> 
