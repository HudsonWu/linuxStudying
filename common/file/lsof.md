# lsof(list open files)
一个列出当前系统打开文件的工具

## 选项
<pre>
lsof -u [user-name]  //列出指定用户的进程打开的文件
lsof -c [process-name]  //列出指定进程打开的文件
lsof -p [PID]  //列出指定进程打开的文件
lsof -p [^PID]  //列出除了指定进程打开的文件外其他所有打开的文件
lsof -t [file-name]  //列出打开了指定文件的进程ID
lsof +d [directory-path]  //显示目录下被进程开启的文件
lsof +D [directory-path]  //显示目录下被进程开启的文件, 还会搜索目录下的目录
lsof -R  //强制列出PPID(Parent Process IDentification)
lsof -p [PID] -R  //列出指定PID打开的文件并加上PPID
lsof -i  //(without any arguments)list all Internet and x.25(HP-UX) network files
lsof -i [4/6] [protocol][@hostname|hostaddr][:service|port]  //列出基于指定网络地址的文件
lsof -i :1-1024  //列出基于端口范围(1到1024)打开的文件
lsof -i udp  //列出指定协议(udp)的文件
</pre>

## 多个选项(OR/AND)
<pre>
1. By default when you use more than one list option in lsof, they will be ORed
lsof -c ssh -c init
lsof -u lakshmanan -c init
2. When you want to list a process belongs to user 'lakshmanan' and process name starts with 'init', you can use '-a' option
lsof -u lakshmanan -c init -a
</pre>

## Execute lsof in repeat mode
<pre>
lsof also support Repeat mode. It will first list files based on the given parameters,
and delay for specified seconds and again list files based on the given parameters.
It can be interrupted by a signal
Repeat mode can be enabled by using '-r' or '+r'. 
If '+r' is used then, the repeat mode will end when no open files are found.
'-r' will continue to list, delay, list until a interrupt is given irrespective of files are opened or not
lsof -u lakshmanan -c init -a -r5
</pre>

## 结果列表
<pre>
字段: COMMAND PID PPID USER FD TYPE DEVICE SIZE/OFF NODE NAME
1. FD  Represents the file descriptor. Some of the values of FDs are,
  cwd, Current Working Directory
  txt, Text file
  mem, Memory mapped file
  mmap, Memory mapped device
  NUMBER, Represent the actual file descriptor.
The character after the number i.e '1u', represents the mode in which the file is opened.
r for read, w for write, u for read and write.
2. TYPE  Specifies the type of the file. Some of the values of TYPEs are,
  REG, Regular File
  DIR, Directory
  FIFO, First In First Out
  CHR, Character special file
</pre>

## 常用情景
<pre>
1. 恢复删除的文件
如文件/var/log/messages被删除了
a. 使用lsof查看当前是否有进程打开/var/log/messages文件
lsof | grep /var/log/messages
syslogd 1283 root 2 REG 3,3 5381017 1773647 /var/log/messages (deleted)
结果显示PID 1283(syslogd)打开了文件, 而且文件描述符为2, 同时文件已经标记被删除了
b. 在/proc/1283/fd/2 (fd下每个以数字命名的文件表示进程对应的文件描述符)中查看相应信息
head -n 10 /proc/1283/fd/2
通过这条命令查看文件是否还在
c. 恢复
cat /proc/1283/fd/2 > /var/log/messages
2. 显示当前进程打开了哪些文件
lsof -p 3097
查看进程号3097打开的文件
3. 查看有哪些进程链接到了指定域名
lsof -i UDP@213162837.yyt.com:1230
lsof -i TCP@213162837.yyt.com:1230 -r
(-r表示不断的查看)
4. 列出正在使用某个挂载点的进程
lsof /home
OR
lsof +D /home/
5. 杀死所有属于某个用户的进程
kill -9 `lsof -t -u lakshmannan`
</pre>
