# ps, processes status

## 简单使用
> ps -fp 1178  //PID
> ps -f --ppid 1154  //PPID
> ps -fp 2226,1154,1146
> ps -t pts/1
> ps -ft tty1
> ps -e --forest  //进程树
> ps -f --forest -C sshd
> ps -ef --forest | grep -v grep | grep sshd
> ps -p 1154 -o comm=  //根据进程id获取进程名
> ps -C sshd -o pid=  //根据进程名获取所有pid
> ps -eo comm,etime,user | grep httpd  //进程运行了多长时间

## 问题查找
1. 发现内存或CPU消耗大的进程
> ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
> ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head
2. 查找并杀死失去响应的进程
> ps -A | grep -i stress
> kill -9 2583 2584
3. 显示安全类信息
> ps -eM
> ps --context
> ps -eo euser,ruser,suser,fuser,f,comm,label
4. 实时进程监控
> watch -n 1 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'

## 扩展用法
> ps aux | sort -rnk 4  //按内存资源的使用量对进程进行排序
> ps aux | sort -rnk 3  //按CPU资源的使用量对进程进行排序