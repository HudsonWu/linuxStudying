## 用途说明
dos2unix命令用来将DOS格式的文本文件转换成UNIX格式的(DOS/MAC to UNIX text file format converter)
DOS下的文本文件是以\r\n作为断行标志的, 表示成十六进制就是0D 0A, 而Unix下的文本文件是以\n作为断行标志的, 表示成十六进制就是 0A, DOS格式的文本文件在Linux下, 用较低版本的vi打开时行尾会显示^M, 而且很多命令都无法很好的处理这种格式的文件, 如果是个shell脚本, 而Unix格式的文本文件在Windows下用Notepad打开时会拼在一起显示
因此产生了两种格式文件相互转换的需求, 对应的将UNIX格式文本文件转成成DOS格式的是unix2dos命令

## 使用
> apt-get install dos2unix  //安装dos2unix工具
> dos2unix file1  //将DOS格式文本文件转换成unix格式(可加-o参数, 也可不加)
> dos2unix file1 file2 file3  //一次转换多个文件
> dos2unix -n oldfile newfile  //将转换的结果保存在新文件中, 原文件不变
> dos2unix -k file1 file2  //保持文件时间戳不变
> find . -type f -exec dos2unix {} +  //将查找出的所有文件格式转换

## 查看文件
> cat -v file1  //-v, 可以看到文件中的非打印字符
> hexdump -C file1  //可以看到文件每个字节的十六进制表示

