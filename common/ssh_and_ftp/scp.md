# scp, 使用ssh协议进行网络传输

## linux和windows之间文件传输

windows下需要安装ssh for windows的客户端软件，如winsshd
```
1. 从linux系统复制文件到windows系统(administrator为windows下用户名)
scp /oracle/a.txt administrator@192.168.1.111:/d:/
2. 将windows下的文件复制到linux系统中
scp administrator@192.168.1.111:/d:/test/abc.txt /oracle
```
