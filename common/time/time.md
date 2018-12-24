# time

## 输出time命令的结果到文件中

```
time的结果是通过标准错误输出的

> (time ./a.sh) >& logfile
> (time ./a.sh) > logfile 2&>1
> (time ./a.sh) 2>&1 | tee logfile

使用{;}指定一组命令
> { time ./a.sh ; } >& logfile
> { time ./a.sh ; } > logfile 2&1
> { time ./a.sh ; } 2>&1 | tee logfile
```

## /usr/bin/time

```
bash内置的命令time和GNU的time命令是不一样的, 通过追加完整的路径/usr/bin/time, 可以执行GNU命令
和内置的bash不同的是, 不加括号也可以将所有的输出重定向到文件

> /usr/bin/time ./a.sh >& logfile
> /usr/bin/time ./a.sh > logfile 2>&1
> /usr/bin/time ./a.sh 2>&1 | tee logfile

而且有输出到文件的选项-o
> /usr/bin/time -o logfile ./a.sh

但是这只会把time的结果写到文件使用追加选项-a就可以了
> /usr/bin/time -a -o logfile ./a.sh > logfile
```
