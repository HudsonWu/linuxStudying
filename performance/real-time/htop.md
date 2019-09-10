## htop, 交互式的进程查看器

htop是一款基于ncurses的Linux进程查看器

与top相比, 有以下优点: <br/>
> + 启动快
> + 杀进程时不需要输入进程号
> + 可以横向或纵向滚动浏览进程列表, 以便看到所有的进程和完整的命令
> + 支持鼠标操作

```
1. Delay between data updates, in tenths of seconds
htop -d 5
htop --delay=10

2. Disable colors
htop -C
htop --no-color
htop --no-colour

3. Show only the process of a given user
htop -u nixcraft
htop --user=nginx
```
