extundelete是基于Linux的一个数据恢复工具

它通过分析文件系统的日志，解析出所有文件的inode信息，从而可以恢复Linux下主流的ext3、ext4文件系统下被误删除的文件。
ext3grep仅支持ext3文件系统的恢复。在恢复速度上，extundelete要快很多，因为extundelete的恢复机制是扫描inode和恢复数据同时进行，并且支持单个文件恢复、单个目录恢复、inode恢复、block恢复、完整磁盘恢复等，而ext3grep就略显笨拙了，它需要首先扫描完要恢复数据的所有inode信息，然后才能开始数据恢复，所以在恢复速度上相对较慢，并且在功能上也不支持目录恢复、时间段恢复等。

在利用extundelete恢复文件时并不依赖特定文件格式，首先extundelete会通过文件系统的inode信息（根目录的inode一般为2）来获得当前文件系统下所有文件的信息，包括存在的和已经删除的文件，这些信息包括文件名和inode。然后利用inode信息结合日志去查询该inode所在的block位置，包括直接块、间接块等信息。最后利用dd命令将这些信息备份出来，从而恢复数据文件

extundelete用法

命令格式
extundelete [option] [action] device-file

option:
-version, -[Vv], 显示软件版本号
-help, 显示帮助信息
-superblock, 显示超级块信息
-journal, 显示日志信息
-after dtime, 时间参数, 表示在某段时间之后被删的文件或目录
-before dtime, 时间参数, 表示在某段时间之前被删的文件或目录

action:
-inode ino, 显示节点"ino"的信息
-block blk, 显示数据块"blk"的信息
-restore-inode ino[,ino,...], 恢复命令参数, 表示恢复节点"ino"的文件
恢复的文件会自动放在当前目录下的RESTORED_FILES文件夹中，使用节点编号作为扩展名
-restore-file 'path', 恢复命令参数, 表示将恢复指定路径的文件
并把恢复的文件放在当前目录下的RESTORED_FILES目录中
-restore-files 'path', 恢复命令参数, 表示将恢复在路径中已列出的所有文件
-restore-all, 恢复命令参数, 表示将尝试恢复所有目录和文件
-j journal, 表示从已经命名的文件中读取扩展日志
-b blocknumber, 表示使用之前备份的超级块来打开文件系统, 一般用于查看现有超级块是不是当前所要的文件
-B blocksize， 通过制定数据块大小来打开文件系统, 一般用于查看已经知道大小的文件
