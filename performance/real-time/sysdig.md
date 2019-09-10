# sysdig, 系统监控、分析和排障的工具

+ [github](https://github.com/draios/sysdig)
+ [official](https://sysdig.com)
+ [install](https://github.com/draios/sysdig/wiki/How-to-Install-Sysdig-for-Linux)
+ [Document](https://github.com/draios/sysdig/wiki)

+ sysdig, a universal system visibility tool with native support for containers
+ csysdig, a simple, intuitive, and fully customizable curses UI for sysdig

## 安装

```
# 一键安装
curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | sudo bash

# 分步安装
## 导入draios源
rpm --import https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public
curl -s -o /etc/yum.repos.d/draios.repo http://download.draios.com/stable/rpm/draios.repo
## 导入epel 源
## rpm -i http://mirror.us.leaseweb.net/epel/6/x86_64/epel-release-6-8.noarch.rpm
## rpm -vih http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
yum -y install epel-release
## 安装包
yum -y install kernel-devel* dkms sysdig

# 容器运行
docker run -i -t --name sysdig --privileged -v /var/run/docker.sock:/host/var/run/docker.sock -v /dev:/host/dev -v /proc:/host/proc:ro -v /boot:/host/boot:ro -v /lib/modules:/host/lib/modules:ro -v /usr:/host/usr:ro sysdig/sysdig
```

## Chisels and Filters

+ Sysdig Chisels, 实用的工具箱, 是最小的Lua脚本, 用于检查sysdig事件流
+ Sysdig Filters, 过滤输出

```
# 列出所有可用的chisels
sysdig -cl

# 查看特定chisel的信息
sysdig -i topprocs_cpu

# 查看可用的输出资源
sysdig -l
```

## 使用实例

### 网络

```
# 查看占用网络带宽最多的进程
sysdig -c topprocs_net

# 显示主机192.168.0.1的网络传输数据
## as binary
sysdig -s2000 -X -c echo_fds fd.cip=192.168.0.1
## as ASCII
sysdig -s2000 -A -c echo_fds fd.cip=192.168.0.1

# 查看连接最多的服务器端口
## 基于established connections
sysdig -c fdcount_by fd.cip "evt.type=accept"
## 基于total bytes
sysdig -c fdbytes_by fd.cip

# 列出所有不是访问apache服务的访问连接
sysdig -p"%proc.name %fd.name" "evt.type=accept and proc.name!=httpd"
```

### 硬盘I/O

```
# 查看使用硬盘带宽最多的进程
sysdig -c topprocs_file

# 列出使用大量文件描述符的进程
sysdig -c fdcount_by proc.name "fd.type=file"

# 查看读写量最多的文件
sysdig -c topfiles_bytes

# 查看从apache读取或写入最多的文件
sysdig -c topfiles_bytes proc.name=httpd

# basic opensnoop: snoop file opens as they occur
sysdig -p "%12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name" evt.type=open

# see the top directories in terms of R+W disk activity
sysdig -c fdbytes_by fd.directory "fd.type=file"

# see the top files in terms of R+W disk activity in the /tmp directory
sysdig -c fdbytes_by fd.filename "fd.directory=/tmp/"

# observe the I/O activity on all the files named 'passwd'
sysdig -A -c echo_fds "fd.filename=passwd"

# display I/O activity by FD type
sysdig -c fdbytes_by fd.type
```

### 进程和CPU使用率

```
# 根据CPU使用率查看top进程
sysdig -c topprocs_cpu

# 查看CPU0的使用率top进程
sysdig -c topproc_cpu evt.cpu=0

# 观察一个进程的标准输出
sysdig -s4096 -A -c stdout proc.name=cat
```

### 性能和错误

```
# 列出花费时间最长的文件
sysdig -c topfiles_time
sysdig -c topfiles_time proc.name=httpd

# 列出I/O错误发生最多的进程
sysdig -c topprocs_errors

# 列出I/O错误发生最多的文件
sysdig -c topfiles_errors

# 列出所有失败的磁盘I/O调用
sysdig fd.type=file and evt.failed=true

# 列出所有打开失败的文件
sysdig "proc.name=httpd and evt.type=open and evt.failed=true"

# 列出花费时间最长的系统调用
sysdig -c topscalls_time
sysdig -c topscalls "evt.failed=true"

# snoop failed file opens as they occur
sysdig -p "%12user.name %6proc.pid %12proc.name %3fd.num %fd.typechar %fd.name" evt.type=open and evt.failed=true

# 列出延迟超过1ms的文件I/O调用
sysdig -c fileslower 1
```

### 安全

```
# 列出root用户访问的目录
sysdig -p "%evt.arg.path" "evt.type=chdir and user.name=root"

# 观察ssh活动
sysdig -A -c echo_fds fd.name=/dev/pretmx and proc.name=sshd

# 列出/etc目录下打开的每一个文件
sysdig evt.type=open and fd.name contains /etc

# show the ID of all the loging shells that have launched the "tar" command
sysdig -r file.scap -c list_login_shells tar

# show all the commands executed by the login shell with the given ID
sysdig -r trace.scap.gz -c spy_users proc.loginshellid=5439
```

### 容器

```
# 查看运行的容器列表及资源使用情况
csysdig -vcontainers

# 查看容器上下文的进程列表
csysdig -pc

# 查看指定容器的资源使用情况
sysdig -pc -c topprocs_cpu container.name=wordpress1
sysdig -pc -c topprocs_net container.name=wordpress1
sysdig -pc -c topfiles_bytes container.name=wordpress1
sysdig -pc -c topconns container.name=wordpress1
sysdig -pc -c spy_users container.name=wordpress1
```

### 应用

```
# 查看所有的HTTP GET请求
sysdig -s 2000 -A -c echo_fds fd.port=80 and evt.buffer contains GET

# 查看所有的SQL select查询
sysdig -s 2000 -A -c echo_fds evt.buffer contains SELECT

# 实时查看apache对mysql服务器的查询请求
 sysdig -s 2000 -A -c echo_fds fd.sip=192.168.30.5 and proc.name=apache2 and evt.buffer contains SELECT
```

```
# the trace dump file
## -w, 输出sysdig结果到文件中
## -r, 从文件中读取
## -s, 指定每个系统事件抓取的数据量
sysdig -s 3000 -w trace.scap
sysdig -r trace.scap proc.name=mongod

# 列出进程
sysdig -c ps

# 监控进程cpu利用率
sysdig -c topprocs_cpu

# 查看网络连接
sysdig -c netstat
sysdig -c topconns
sysdig -c topprocs_net

# 文件I/O
sysdig -c echo_fds
sysdig -c topprocs_files

# 系统瓶颈
sysdig -c bottlenecks

# 进程执行时间
sysdig -w extime.scap -c proc_exec_time
sysdig -r extime.scap proc.name=postgres

# 发现缓慢网络I/O
sysdig -c netlower

# 日志
sysdig -c spy_syslog
sysdig -c spy_logs

# 监控http请求
sysdig -c httplog
sysdig -c httptop

# 登录信息
sysdig -c list_login_shells
sysdig -c spy_users
```
