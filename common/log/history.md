history

1. 使用HISTTIMEFORMAT在历史中显示TIMESTAMP
export HISTTIMEFORMAT='%F %T '

2. history 10

3. Ctrl+R搜索历史命令

4. vi ~/.bash_profile
HISTSIZE=450  控制历史命令的总数
HISTFILE=/root/.commandline_warrior 改变存储历史命令的文件(默认在.bash_history)
可以使用这个命令来追踪不同终端中执行的命令

5. 使用HISTCONTROL消除命令历史中的连续重复条目
export HISTCONTROL=ignoredups

6. 使用HISTCONTROL去除整个命令历史中的重复命令
export HISTCONTROL=erasedups

7. 清除历史命令
history -d 2038  清除指定历史命令
history -c 清除所有历史命令
history -w 将内存中的记录写入到文件
cat /dev/null > ~/.bash_history  清除历史命令文件中的记录
history -r 重置文件里的内容到内存中

8. export HISTSIZE=0 禁用history，不让bashshell记录你的命令
