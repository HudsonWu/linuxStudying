# pstree, 以树状图的方式展现进程之间的派生关系

树状图将会以pid(如果有指定)或是以init为根(root), 如果指定使用者id, 则树状图只会显示该使用者所拥有的进程 <br/>

## 选项

```
-a, 显示每个进程的完整指令, 包括路径, 参数或是常驻服务的标示
-c, 不使用精简标示法, 如果有重复的进程名, 则分开列出
-G, 使用VT100终端机的列绘图字符
-h, 列出树状图时, 特别标明现在执行的进程
-H <进程PID>, 和-h参数类似, 但特别标明指定的进程
-l, 采用长列格式显示树状图
-n, 用进程PID排序, 预设是以进程名称排序
-p, 显示进程PID
-u, 显示用户名称
-U, 使用UTF-8列绘图字符
-v, 显示版本信息
```

## 使用实例

```
pstree, 以树状图显示进程, 只显示近程的名字, 且相同进程合并显示
pstree -p, 以树状图显示进程, 且显示进程PID
pstree <pid>, 以树状图显示进程PID为<pid>的进程以及子孙进程, 
              如果有-p参数则同时显示每个进程的PID
pstree -a, 以树状图显示进程, 相同名称的进程不合并显示, 并且会显示命令行参数
pstree -apnh, 显示进程间的关系
pstree -ap | grep 'exam_prog_name', 查找指定程序的进程树
```
