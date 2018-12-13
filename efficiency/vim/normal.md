## 剪贴板

vim提供12个剪贴板, 分别是 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, a " <br/>
如果开启了系统剪贴板, 则会另外多出两个:  +, * <br/>
```
使用 :reg 命令可以查看各个粘贴板里的内容
1. 简单复制和粘贴
在vim中简单用y只是复制到 " 粘贴板里, 用p粘贴的也是这个粘贴板里的内容

2. 复制和粘贴到指定剪贴板
复制: 进入正常模式后, 选择要复制的内容, 然后按 "Ny 完成复制, 其中N为粘贴板号
例如要把内容复制到粘贴板a, 选中内容后按 "ay 就可以了
粘贴:  "Np
例如将全局粘贴板里的内容粘贴进来, 按 "+p
```

## 撤销

### 简单撤销
1. 在Normal mode下使用u命令, 或者在Command mode下使用:undo命令, 可以撤销上一次的操作

2. 使用U命令, 可以撤销所有针对当前行最近所做的修改

3. vim可以进行多次撤销, 可以使用选项undolevels来指定次数
```
:set undolevels=5000
```

4. 重做被撤销的操作, 使用:redo 或 CTRL-R 命令

### 分支
如果你先撤销了若干改变, 然后又进行了一些其它的改变, <br/>
此时, 被撤销的改变就成为一个分支, 可以使用 :undolist 命令来查看修改的各个分支 <br/>
```
编号 改变 时间
编号列是改变号, 这个编号持续增加, 用于标识特定可撤销的改变
改变列是根结点到此叶结点所需的改变数目
时间列是此改变发生的时间
1） 使用 :undo 命令并指定编号作为参数, 则能够撤销到某个分支
2） 在不同的撤销分支间跳转, 使用 -g 命令可以回到较早的文本状态, 而 g+ 命令则返回较新的文本状态
3） 根据时间撤销操作, :earlier 10m 命令退回到10分钟前的文本状态, :later 5s 命令跳转到5秒以后的编辑状态
4） :help undo-tree 和 :help usr_32.txt命令可以查看撤销操作的帮助信息
```