# tmux的滚屏

## 启用鼠标滚动

快捷键`C-b :`或者配置文件`~/.tmux.conf`：
```
set -g mouse on    # For tmux version 2.1 and up
set -g mode-mouse on    # For tmux versions < 2.1
```

## 进入复制模式

快捷键`C-b [`进入复制模式，然后使用emacs或vi键绑定进行滚动，按`q`退出：
```
set -g mode-keys vi
```
