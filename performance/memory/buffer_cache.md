# buffer and cache

```
A buffer is something that has yet to be "written" to disk.
A cache is something that has been "read" from the disk and stored for later use.
```

## sync, 强制将内存缓冲区的数据写入磁盘

sync命令用于强制被改变的内容立刻写入磁盘, 更新超块信息 <br/>

在Linux/Unix系统中, 在文件或数据处理过程中一般先放到内存缓冲区中, 等到适当的时候再写入磁盘, 以提高系统的运行效率 <br/>
sync命令则可用来强制将内存缓冲区中的数据立即写入磁盘中, 用户通常不需执行sync命令, 系统会自动执行update或bdflush操作, 将缓冲区的数据写入磁盘 <br/>
只有在update或bdflush无法执行或用户需要非正常关机时, 才需手动执行sync命令 <br/>

## 手动释放缓存 (`/proc/sys/vm/drop_cache`)

当在linux下频繁存取文件后, 物理内存会很快被用光, 当程序结束后, 内存不会被正常释放, 而是一直作为caching <br/>
为了提高磁盘存取效率, linux做了一些精心的设计, 除了对dentry进行缓存(用于VFS, 加速文件路径名到inode的转换), 还采取了两种主要Cache方式: Buffer Cache(针对磁盘块的读写), Page Cache(针对文件inode的读写), 这些Cache有效缩短了I/O系统调用的时间 <br/>
/proc是一个虚拟文件系统, 可以通过对它的读写操作作为与kernel实体间进行通信的一种手段, 也就是说可以通过修改/proc中的文件, 来对当前kernel的行为做出调整 <br/>

可以通过调整`/proc/sys/vm/drop_caches`来释放内存(需要先执行sync命令) <br/>
```
Writing to this file causes the kernel to drop clean caches, dentries and inodes from memory, 
causing that memory to become free.

echo 1 > /proc/sys/vm/drop_caches    //To free pagecache
echo 2 > /proc/sys/vm/drop_caches    //To free dentries and inodes
echo 3 > /proc/sys/vm/drop_caches    //To free pagecache, dentries and inodes

Because this is a non-destructive operation and dirty objects are not freeable,
the user should run sync first.
```

对于系统内存是否够用的观察, 更多地去关注swap的使用率和si/so两个值的大小, 手动释放缓存适用于临时性需求
