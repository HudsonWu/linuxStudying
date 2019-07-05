# sftp配置

一般系统安装了ssh后, 默认就安装了sftp服务. 
但sftp账号基于SSH账号, 默认情况下访问服务器的权限很大, 需要做一些配置.

## 步骤

1. 创建一个用户组, 专门用于sftp用户
```sh
groupadd sftpusers
```

2. 创建用户
```sh
useradd -s /bin/false -G sftpusers test
```
将用户的shell设置为/bin/false使之没有登录shell的权限

3. 编辑/etc/ssh/sshd_config
```
# 使用internal-sftp而不用默认的sftp-server, 原因是:
## 这是一个进程内的sftp服务, 当用户ChrootDirectory时, 将不请求任何文件
## 更好的性能, 不用为sftp再开一个进程
Subsystem sftp internal-sftp

# 在文件末尾处添加配置, 设定属于用户组sftpusers的用户只能访问他们自己的home文件夹
## 匹配用户组，如果要匹配多个组，多个组之间用逗号分割
Match Group sftpusers

## 指定根目录
### 由于chroot的目录及其父目录所有者必须是root, 且对其他用户不可写
### 可把ChrootDirectoy设置为/sftp
#ChrootDirectory %h  # 设置为用户主目录
ChrootDirectory /sftp  # 设置为指定目录

## 指定 sftp 命令
ForceCommand internal-sftp

## 这两行，如果不希望该用户能使用端口转发的话就加上，否则删掉
X11Forwarding no
AllowTcpForwarding no
```

4. 修改用户home文件夹的权限, 让其属于root
```sh
chown root /sftp
```
ChrootDirectory的权限问题: 设定的目录必须是root用户所有, 否则会出现问题, 所以确保sftp用户根目录的所有人是root, 权限是750或755
```
目录开始一直往上到系统根目录为止的目录拥有者都只能是root
目录开始一直往上到系统根目录为止都不可以具有群组写入权限
```

5. 重启sshd

6. 测试
```
ssh test@localhost
sftp test@localhost
```

7. 记录日志

```
# /etc/ssh/sshd_config
Subsystem sftp internal-sftp -l INFO

# 日志记录级别
QUIET, FATAL, ERROR, INFO, VERBOSE, DEBUG, DEBUG1, DEBUG2, DEBUG3
```
