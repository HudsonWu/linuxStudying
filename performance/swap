## swap设置

可以在/etc/sysctl.conf里设置vm.swappiness参数<br/>
设置成vm.swappiness=10, 就是说当内存使用90%以上才会使用swap空间<br/>

## 释放linux的swap内存

有的时候, 内存会被缓存占用, 导致系统开始使用swap空间, 此时就需要清理下swap了<br/>

1. 先执行sync命令
```
sync  
```

sync命令可用来强制将内存缓冲区中的数据立即写入磁盘中<br/>

2. drop_caches
```
echo 3 > /proc/sys/vm/drop_caches  
```
此指令输入立即生效, 意在释放所有缓存

3. 关闭swap, 再开启swap
```
swapoff -a
swapon -a
```

