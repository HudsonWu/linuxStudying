# 一些有用的命令

```
# 查看网卡带宽
ethtool eth0
cat /sys/class/net/eth0/speed
dmesg | grep eth0 | grep up
mii-tool -v eth0
```
