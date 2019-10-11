# tcp连接

```
# 查看动态端口范围
netsh int ipv4 show dynamicportrange tcp

# 修改可用端口
netsh int ipv4 set dynamicport tcp start=2000 num=63000

# 统计tcp连接个数
netstat -an | find "TCP" /C
netstat -an | find "TIME_WAIT" /C

# time_wait超时时间调整
## regedit
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters
"MaxUserPort"=dword:0000fffe
"TcpTimeWaitDelay"=dword:0000005 (缩短为5秒)
```
