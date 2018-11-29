## 简介
expect是linux脚本编程工具语言, 用来实现自动和交互式任务进行通信, 从而不用手动处理
核心功能: 对于设定好的特定匹配形式, 以相匹配的动作以应对
每一个expect后所跟的字符串(或者正则表达式)就是脚本所等待的匹配模式, 每一个send所做的工作就是对于各种的模式串, 实施相应的动作

## 选项和参数
<pre>
# 选项
-c, 执行脚本前先执行的命令, 可多次使用
-d, debug模式, 在运行时输出一些诊断信息, 与在脚本开始处使用exp_internal 1 相似
-D, 启用交换调式器, 可设一些整数参数
-f, 从文件读取命令, 仅用于使用#!时, 如果文件名为"-", 则从stdin读取
-i, 交互式输入命令, 使用"exit"或"EOF"退出输入状态
--, 标示选项结束
-v, 显示expect版本信息

# 命令行参数
$argv, 参数数组, 使用[lindex $argv n]获取
$argc, 参数个数

# 命令介绍
spawn, 包装一个子进程, 即给子进程加壳
expect, 监听子进程的stdout/stderr, 如果匹配成功, 则执行定义的命令
send, 将给定的数据写入子进程的stdin文件
close, 关闭当前进程的连接
debug, 控制调试器
disconnect, 断开进程连接(进程仍在后台运行)
priv_prog, 定时读取密码
exit, 退出expect
exp_continue, 继续匹配下一次输入
expect eof, 等待标示子进程已结束的标示符eof, 然后退出
(这个等待eof必须要有, 如果没有eof, 很可能在子进程没有结束前就退出, 造成问题)
("eof"只是一个普通字符串, 可以选择任意不会出现的字符串替代它)

默认expect语句使用shell通配符匹配, 有时候无法满足要求, 可以使用-re选项开启正则匹配
expect -re "regex"
expect { -re "regex" { send "str\r" } }
</pre>

## 简单使用
<pre>
#!/usr/bin/expect
# ---------- 配置信息开始 ----------
# 变量
set user [lindex $argv 0]  # 获取第一个参数
set password heiheiPsd
# expect 脚本配置
set timeout -1  # 设置超时时间, 单位是秒, 默认为10s, -1表示不会超时
# ---------- 配置信息结束 ----------

# spawn, 启动一个命令或程序, 并由expect程序开始监听
spawn ssh $user@192.168.0.110
# expect, 判断上次输出结果是否包含字符串或匹配正则表达式, 如果有则返回, 否则等待一段时间后返回
# 等待时间即设置的超时时间
expect "*password:"
# send, 执行交互动作, 与手工输入的动作等效
# 命令字符结尾加上\r
send "$password\r"
# interact, 执行完成后保持交互状态, 把控制权交给控制台
# 如果没有这一句, 登录完成后会退出
interact
</pre>

## 与bash共用
<pre>
#!/bin/bash
echo "this bash func"
#---------expect开始----------
set password fenglican 
set timeout -1

expect<<- END
spawn ssh root@192.168.88.888
expect "*password:"
send "$password\r"
interact

END
#---------expect结束----------
</pre>
