# fd, file descriptor, 文件描述符

file descriptor, 简单地说就是当unix-like的OS在读取文件时会把每一个文件编号, 此编号是Kernel用来追踪process开启文件输出/输入的索引

## fd与重定向

有三个fd文件是永远开启的: stdin(键盘), stdout(屏幕), stderr(错误信息). 且POSIX标准保留这三个文件的fd编号各位0~2供使用者操作重定向(redirection)

```
fd Number    Name    Function
    0        stdin    标准输入
    1        stdout   标准输出
    2        stderr   标准错误
```
重定向实际上就是把三个永不关闭的fd 0~2重定向到其他地方(大部分为文件或另一fd)

```
1>    stdout重定向      echo '123' > fileA
1>>   stdout累加重定向  seq 100 200 >> fileA
2>    stderr重定向      find / -name '*.conf' 2>/dev/null
2>>   stderr累加重定向  seq 1 10 >> fileA
0<    stdin重定向       cat < fileA
```
输出重定向语法为`COMMAND [fd]>`, 如省略fd, 预设为1; 
输入重定向语法为`COMMAND [fd]<`, 如省略fd, 预设为0

重定向可改变stdout到stderr, 反之也可把stderr改到stdout, 其语法为`X>&Y`(X为原fd, Y为重定向后的fd, X如省略预设为1)
```
2>&1    stderr(2)重定向到stdout(1)      ls -R /home > fileA 2>&1
1>&2    stdout重定向到stderr        find / -name '*readme.txt' 1>&2 2>/dev/null
```

stdin, stdout, stderr (fd 0~2)这三个是永远开启的, 如fd大于3一般要用exec来开启

## `/proc/<PID>/fd`与fd

当process运行时会产生一个PID, 相对的会映射到目录`/proc/<PID>/fd`, 此目录可观察file descriptor的使用情形

```
$ seq 1 1000000
... //省略前面的输出
31054
31055
31056
^Z  //按<Ctrl-Z>暂停
[1]+  Stopped                 seq 1 1000000
$ jobs -p  //列出暂停的命令的PID
3881
$ ls -lgG /proc/3881/fd/    //观察fd使用情况
total 0
lrwx------ 1 64 Jan 10 22:17 0 -> /dev/pts/1
lrwx------ 1 64 Jan 10 22:17 1 -> /dev/pts/1
lrwx------ 1 64 Jan 10 22:17 2 -> /dev/pts/1
$ seq 1 1000000000 > fileA 2>&1
^Z
[2]+  Stopped                 seq 1 1000000000 > fileA 2>&1
$ jobs -p
3881
3931
$ ls -lgG /proc/3931/fd/
total 0
lrwx------ 1 64 Jan 10 22:31 0 -> /dev/pts/1
l-wx------ 1 64 Jan 10 22:31 1 -> /root/test/fileA
l-wx------ 1 64 Jan 10 22:31 2 -> /root/test/fileA
$ seq 1 1000000 > fileB >&2
...
38714
38715
38716
^Z
[3]+  Stopped                 seq 1 1000000 > fileB 1>&2
$ jobs -p
3881
3831
3954
$ ls -lgG /proc/3954/fd/
total 0
lrwx------ 1 64 Jan 10 22:36 0 -> /dev/pts/1
lrwx------ 1 64 Jan 10 22:36 1 -> /dev/pts/1
lrwx------ 1 64 Jan 10 22:36 2 -> /dev/pts/1
```
