# reflink

reflink是区别于symlink和hardlink的第三种link的存在

+ symlink是创建一个符号连接文件, 此文件的内容保存着目标路径
+ hardlink是创建一个相同inode号的文件, 文件名不同但是inode是同一个(限制是只能在同一文件系统内创建)
+ reflink是创建一个新的inode, 但是这个新的inode和目标inode共享相同的磁盘空间, 直到新的内容被写入到新的inode里. 这就是一个copy on write的实现, 可以实现快速的拷贝
