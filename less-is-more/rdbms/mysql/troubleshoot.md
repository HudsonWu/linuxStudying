1. 查看mysql里的线程, 观察是否有长期运行或阻塞的sql
```
show full processlist
```
2. 查看Mysql内存
```
show global variables like '%sort_buffer_size%'
```
