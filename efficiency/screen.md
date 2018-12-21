# screen, 多重视窗管理程序

## 语法
```
screen [-AmRvx -ls -wipe][-d <作业名称>][-h <行数>][-r <作业名称>][-s ][-S <作业名称>]

参数说明
-A 　将所有的视窗都调整为目前终端机的大小
-d <作业名称> 　将指定的screen作业离线
-h <行数> 　指定视窗的缓冲区行数
-m 　即使目前已在作业中的screen作业, 仍强制建立新的screen作业
-r <作业名称> 　恢复离线的screen作业
-R 　先试图恢复离线的作业若找不到离线的作业, 即建立新的screen作业
-s 　指定建立新视窗时, 所要执行的shell
-S <作业名称> 　指定screen作业的名称
-v 　显示版本信息
-x 　恢复之前离线的screen作业
-ls或--list 　显示目前所有的screen作业
-wipe 　检查目前所有的screen作业, 并删除已经无法使用的screen作业
```

## Usage

### 命令和快捷键
```
//创建一个新的窗口
> screen -S david  //-S, 指定session名
> screen vi test.txt  //打开指定的程序

//查看窗口和窗口名称
快捷键: "C-a w"

//会话分离与恢复
快捷键: "C-a d"
> screen -d  //将当前screen离线

> screen -ls  //列出当前所有的session
> screen -r 12865  //重新连接会话
> screen -wipe  //清除dead会话

//关闭或杀死窗口
快捷键: "C-a k"

//会话共享
> screen -x

//会话锁定与解锁
锁定快捷键: "C-a s"  "C-a x"  (需要密码继续访问)
解锁快捷键: "C-a q"

//发送命令到screen会话
> screen -S sandy -X screen ping www.baidu.com

//屏幕分割
水平分割: "C-a S"
垂直分屏: "C-a |"
区块间切换: "C-a <tab>"

关闭当前焦点所在屏幕区块: "C-a X"
关闭除当前区块外的其他所有区块: "C-a Q"
关闭的区块中的窗口并不会关闭, 还可以通过窗口切换找到它
```

### C/P模式和操作
```
screen的另一个很强大的功能就是可以在不同窗口之间进行复制粘贴
使用快捷键"C-a <Esc>"或者"C-a ["可以进入copy/paste模式
这个模式下可以像在vi中一样移动光标, 并可以使用空格键设置标记
其实在这个模式下有很多类似vi的操作, 譬如使用/进行搜索, 使用y快速标记一行, 使用w快速标记一个单词等关于C/P模式下的高级操作

一般情况下, 可以移动光标到指定位置, 按下空格设置一个开头标记, 然后移动光标到结尾位置, 按下空格设置第二个标记, 
同时会将两个标记之间的部分储存在copy/paste buffer中, 并退出copy/paste模式在正常模式下, 
可以使用快捷键"C-a ]"将储存在buffer中的内容粘贴到当前窗口
```

### 更多
```
你可以在Screen的默认两级配置文件/etc/screenrc和$HOME/.screenrc中指定更多, 
例如设定screen选项, 定制绑定键, 设定screen会话自启动窗口, 启用多用户模式, 定制用户访问权限控制等等, 
如果你愿意的话, 也可以自己指定screen配置文件 

以多用户功能为例, screen默认是以单用户模式运行的, 你需要在配置文件中指定multiuser on 来打开多用户模式, 
通过acl*（acladd,acldel,aclchg...）命令, 你可以灵活配置其他用户访问你的screen会话, 更多配置文件内容请参考screen的man页
```

