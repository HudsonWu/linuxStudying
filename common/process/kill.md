## kill

kill命令用于终止指定进程

## 信号 (signal)
<pre>
HUP    1   终端断线
INT    2   中断 (同 Ctrl+c)
QUIT   3   退出 (同 Ctrl+\)
TERM   15  终止
KILL   9   强制终止
CONT   18  继续 (与STOP相反, fg/bg命令)
STOP   19  暂停 (同 Ctrl+z)
</pre>

## 命令
<pre>
kill -l  列出所有信号名称
kill -l <signame>  显示指定信号的数值
kill -9 <pid>
kill -KILL <pid>  强制杀掉指定进程
kill %<jobid>  杀掉指定的任务 (使用jobs命令列出任务)
kill -9 %<jobid>
</pre>
