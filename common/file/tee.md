tee命令

## what
读取标准输入, 把这些内容输出到标准输出和(多个)文件中
(既想把输出保存到文件中, 又想在屏幕上看到输出内容)
(存在缓存机制, 每1024个字节将输出一次, 若从管道接收输入数据, 应该是缓冲区满, 才将数据转存到指定的文件中;
若文件内容不到1024个字节, 则接收完从标准输入读入的数据后, 将刷新一次缓冲区, 并转存数据到指定文件)

## 语法
tee [-ai][--help][--version][文件...]
选项:
-a或--append  附加到既有文件的后面, 而非覆盖
-i或--ignore-interrupts  忽略中断信号
--help  在线帮助
--version  显示版本信息

## 实例
tee file1 file2  将用户输入的数据同时保存到file1和file2中
ls | tee out.txt
ls将输出当前目录列表, 这个输出被管道送入tee命令, tee将该输入内容直接输出的同时, 转存到out.txt文件
ls | tee out.txt | cat -n