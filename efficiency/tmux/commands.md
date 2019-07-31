# 信息查询

```
# 列出所有可用的快捷键和其运行的命令
tmux list-keys

# 列出所有的tmux命令及其参数
tmux list-commands

# 列出所有的session、window、pane, 运行的进程号等
tmux info
```

## session, 会话

session是一个特定的终端组合, 输入tmux就可以打开一个新的session

```
# 创建session
tmux new -s session_name

# 进入session
tmux attach -t session_name

# 转换session
tmux switch -t session_name

# 列出session
tmux list-sessions
tmux ls

# 离开session
tmux detach

# 关闭所有session
tmux kill-server
```

## window, 窗口

session中可以有不同的window, 但同时只能看到一个window

```
# 创建新window
tmux new-window

# 列出window
tmux list-windows

# 根据索引转到该window
tmux select-window -t :0-9

# 重命名当前window
tmux rename-window
```

## pane, 面板

window中可以有不同的pane, 把window分成不同的部分

```
# 垂直划分为两个pane
tmux split-window

# 水平划分为两个pane
tmux split-window -h

# 在指定的方向交换pane
tmux swap-pane-[UDLR]

# 在指定的方向选择下一个pane
tmux select-pane-[UDLR]
```
