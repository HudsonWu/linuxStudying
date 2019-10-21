# mount

## 解决umount: device is busy

```
# 查看哪些程序占用挂载目录
fuser -m /mount/path
# 杀掉占用的程序
kill -9 pid
# 强行解除挂载
umount -l /mount/path
# 一步到位
fuser -kvm /mount/path
```
