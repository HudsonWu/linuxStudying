# netsh, network shell

netsh是一个能够通过命令行操作所有网络相关设置的接口, 
比如设置IP, DNS, 网卡, 无线网络等

```
# 查看帮助信息
netsh winsock ?

# 重置winsock目录
# 重新初始化网络环境
netsh winsock reset

# 查看tcp/ip设置
netsh interface ip show config

# 改变网络配置
## 静态ip
netsh interface ip set
  address "Local Area 
  Connection" static
  192.168.0.10 255.255.255.0
  192.168.0.254
## dhcp
netsh interface ip set
  address "Local Area
  Connection" dhcp
## 改变dns服务器地址
netsh interface ip set dns
  "Local Area Connection"
  static 192.168.0.2
netsh interface ip set dns
  "Local Area Connection" dhcp
# 配置WINS server
netsh interface ip set wins
  "Local Area Connection"
  static 192.168.100.3

# dump
## 导出本地DHCP服务配置信息
netsh dhcp dump > dhcpcfg.dat
## 导出网络配置信息
netsh interface dump > mycfg.dat
## 恢复网络配置
netsh exec mycfg.dat

# 远程系统
netsh set machine remotecomputer

# 查看网卡的MTU
netsh interface ipv4 show subinterfaces
```

## 修改动态端口

```
# 查看
netsh int ipv4 show dynamicport tcp
netsh int ipv4 show dynamicport udp
netsh int ipv6 show dynamicport tcp
netsh int ipv6 show dynamicport udp

# 设置
netsh int ipv4 set dynamicport tcp start=10000 num=1000
netsh int ipv4 set dynamicport udp start=10000 num=1000
netsh int ipv6 set dynamicport tcp start=10000 num=1000
netsh int ipv6 set dynamicport udp start=10000 num=1000
```
