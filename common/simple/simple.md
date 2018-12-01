## dpkg
<pre>
1. 查询某个包是否安装
> dpkg -s
> dpkg-query -l
> dpkg -l | grep
2. 列出系统中安装的所有包
> dpkg --get-selections
3. 查看某个包中文件的位置
> dpkg -L
4. 安装deb包
> dpkg -i
5. 删除deb包
> dpkg -r
6. 彻底卸载软件包
> dpkg -P
</pre>

## scp
<pre>
windows下需要安装ssh for windows的客户端软件，如winsshd
1. 从linux系统复制文件到windows系统(administrator为windows下用户名)
> scp /oracle/a.txt administrator@192.168.1.111:/d:/
2. 将windows下的文件复制到linux系统中
> scp administrator@192.168.1.111:/d:/test/abc.txt /oracle
</pre>

## cat
<pre>
1. 一次显示整个文件 cat filename
2. 从键盘创建一个文件 cat > filename 只能创建新文件，不能编辑已有文件
3. 将几个文件合并为一个文件 cat file1 file2 > file
选项
-n 由1开始对所有输出的行数编号
-b 对于空白行不编号
-s 当遇到有连续两行以上的空白行，就替换为一行的空白行
> cat -n textfile1 > textfile2 把1文件内容加上行号后输入2文件里
> cat /dev/null > /etc/test.txt 把text.txt文件扔进垃圾箱，赋空值test.txt
> cat > file1 << EOF 向file1输入内容（>为创建，>>为追加），内容输入完以EOF结束
</pre>

## lrzsz
<pre>
> xshell上传下载工具包: rz和sz (receive和send)
> apt-get install lrzsz
</pre>

## readlink
<pre>
readlink是Linux系统中一个常用工具，主要用来找出符号链接所指向的位置
print value of a symbolic link or canonical file name 输出符号链接值或者权威文件名
-f选项：递归跟随给出文件名的所有符号链接，直到非符号链接的文件位置

> readlink /usr/bin/awk
> readlink -f /usr/bin/awk
</pre>

## rpm
<pre>
(-q, 表示查询query)
> rpm -qa  // 列出所有安装过的包(all)
> rpm -ql 包名  // 查询rpm包的文件安装路径(list)
> rpm -qlp ***.rpm  // 查询没有安装的软件包包含哪些文件(package)
> rpm -qip ***.rpm  // 获取一个未安装软件包的版本、用途等信息(info)
> rpm -qi 包名  // 获取已安装软件包的版本、用途等信息
> rpm -qf `which 程序名`  // 返回软件包的全名(file)
> rpm -qif `which 程序名`  // 返回软件包的相关信息
> rpm -qlf `which 程序名`  // 返回软件包的文件列表
> rpm -qilf `which 程序名`  // 同时返回软件包信息和文件列表
</pre>

## runlevel
<pre>
1. Linux的运行级别：init  /etc/inittab
0 ：关机
1 ：单用户
2 ：多用户无网络服务
3 ：多用户有网络服务
4 ：系统未使用保留给用户
5 ：图形界面
6 ：重新启动
常用的运行级别是3和5
2. Linux预设了六个命令窗口终端机tty1 ~ tty6 (ctrl+alt+F1~F6)
ctrl+alt+F7 为图形界面
</pre>

## apt-get
<pre>
编译工具安装
> sudo apt-get install autoconf
> sudo apt-get install build-essential build-dep
安装软件对应的依赖
> sudo apt-get build-dep audacity
下载软件源代码
> sudo apt-get source audacity
源码安装失败时
> sudo dpkg-buildpackage -b -uc -us
</pre>

## vesion
<pre>
查看linux内核版本
> cat /proc/version
> uname -a
> uname -r
查看linux系统版本
> lsb_release -a
> cat /etc/issue
> cat /etc/os-release
> lsb_release -cs
</pre>
