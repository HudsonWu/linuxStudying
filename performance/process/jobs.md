# linux 中 fg, bg, jobs 等指令

<pre>
&, 用在一个命令最后, 将这个命令转换为后台运行的任务进程
jobs, 查看当前终端有多少在后台运行的进程
fg, 将后台任务进程调至前台继续运行
bg, 将挂起的任务进程重新启动运行
Ctrl+z, 将一个正在前台执行的命令放到后台并且暂停
nohup, 不挂断地运行命令 (nohup command &)
</pre>

## jobs
<pre>
jobs命令执行的结果, + 表示是一个当前的作业, - 表示是一个当前作业之后的一个作业
jobs -l 选项可显示所有任务的进程号pid
jobs的状态可以是 running, stopped, terminated
如果任务进程被终止(kill)了, 当前终端环境也就删除了任务的进程标识
jobs命令显示的是当前shell环境中后台正在运行或者被挂起的任务进程信息
</pre>

## fg 和 bg
<pre>
fg %num 将选中的任务进程调至前台
bg %num 将挂起的任务进程状态由 stopped 改为 running, 仍在后台运行
%num是通过jobs命令查到的后台正在执行的任务序号
</pre>

## 进程的终止
<pre>
kill %num
kill pid
</pre>
