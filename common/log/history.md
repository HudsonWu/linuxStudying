# history命令

## 配置项

+ 设置执行命令时输出结果中显示命令执行时间
  + `export HISTTIMEFORMAT='%F %T '`
+ 控制历史命令记录的数目
  + `export HISTSIZE=450`
+ 改变历史命令的存储文件 (默认是`.bash_history`)
  + `export HISTFILE=~/.commandline_warrior`
+ 不允许连续重复命令
  + `export HISTCONTROL=ignoredups`
+ 不允许重复命令
  + `export HISTCONTROL=erasedups`
+ 不记录历史命令
  + `export HISTSIZE=0`
  
## 常用命令

```
# 最近执行的10命令
history 10

# 清除指定历史命令记录
history -d 2038

# 清除当前shell下所有执行过命令的记录
history -c

# 将内存中的命令记录写入到文件
history -w

# 清除历史命令记录文件中的内容
cat /dev/null > ~/.bash_history

# 重置历史命令记录文件的内容到内存中
history -r
```

## 一些命令技巧

```
# 获取历史命令并执行
!!  # 上一条命令
!foo  # 最近执行的以foo开头的命令
!?foo  # 最近执行的含有foo的命令
!n  # history执行后显示的第n个命令
!-n  # history执行后显示的倒数第n个命令

# 删除上一条命令的指定字符串后执行
^err  # 只删除第一次查找到的字符串

# 替换上一条命令的指定字符串后执行
^old^new  # 只替换第一次查找到的字符串
!:gs/old/new  # 替换所有查找到的字符串

# 获取上条命令的参数
!$  # 最后一个参数
!!:$  # 最后一个参数
!^  # 第一个参数
!!:^  # 第一个参数
!:n  # 第n个参数
!:x-y  # 第x个参数到第y个参数
!:n*  # 第n个参数到最后一个参数
!*  # 所有参数

# 字符串截取选项
:h  # 选取路径开头, 
:t  # 选取路径结尾, 
:r  # 选取文件名,
:e  # 选取扩展名,
# 如前一条命令为ls /usr/share/fonts/truetype, 
# 执行cd !!:$:h相当于cd /usr/share/fonts

# 执行指令选项
:p  # 打印命令行
:s  # 做替换
:g  # 全局
```

## Reference

<https://www.ibm.com/developerworks/cn/linux/l-10sysadtips>

