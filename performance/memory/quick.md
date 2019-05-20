# 快速指南

## 新增swap (使用文件)

swap大小建议:
  + 内存小于2GB, 内存大小 * 2
  + 内存大于2GB, 内存大小 + 2

1. 编辑启用swap的触发条件

vi /etc/sysctl.conf
```
# 文件内容修改
vm.swappiness = 15

# 执行命令使其生效
sysctl -p
```

2. 停止所有swap
```
swapoff -a
```

3. swap文件

```
# 创建文件
dd if=/dev/zero of=/var/swapfile bs=1M count=10240  (8G)
dd if=/dev/zero of=/var/swapfile bs=1M count=18432  (16G)
# 格式化
mkswap /var/swapfile
# 更改权限
chmod 600 /var/swapfile
# 启用
swapon /var/swapfile
# 添加以下行到/etc/fstab文件, 配置开机自启
/var/swapfile swap swap defaults 0 0
```
