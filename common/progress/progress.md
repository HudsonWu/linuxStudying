# progress
<pre>
曾用名为Coreutils Viewer, 使用C语言开发, 用来显示Linux命令执行进度的工具
支持cp, mv, tar, dd, gzip/gunzip, cat, grep等
源代码: https://github.com/Xfennec/progress
</pre>

## 安装
> //progress依赖libncurses显示进度条<br/>
> yum install ncurses-devel  //CentOS<br/>
> dnf install ncurses-devel  //Fedora 22<br/>
> apt-get install libncurses5-dev  //ubuntu<br/>

## 使用
<pre>
先执行要监控的命令, 然后打开另一个终端, 运行progress命令

progress首先搜索/proc, 找到要监控的命令, 然后搜索fd和fdinfo目录, 找到打开的文件,
计算执行进度

> watch progress -q
</pre>
