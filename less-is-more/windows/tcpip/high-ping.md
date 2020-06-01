# fix high ping on windows 10

## 修改注册表 (regedit)

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile

修改NetworkThrottlingIndex
基数(Base)选择十六进制(Hexadecimal)，值修改为FFFFFFFF
```

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\
Interfaces下的子目录(subkey, folder)代表网络连接(network connection)
选中子目录，根据右边数据的ip地址值(ip address)、网关(gateway)等判断是哪个网络连接

选中正确的子目录，右键新增两个 DWORD (32-bit) Value，
命名为 TCPackFrequency 和 TCPNoDelay，修改值为1
```

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ

1. 新增一个 DWORD (32-bit) Value，命名为TCPNoDelay，修改值为1
2. 确保MSMQ下有名为Parameters的子目录，没有则右键新建（新建项(Key)）
3. 在Parameters下新增一个 DWORD (32-bit) Value，命名为TCPNoDelay，修改值为1




```
