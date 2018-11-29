git log

# 提交的输出格式

## 格式化log输出
1. --oneline, 把每一个提交显示在一行中, 默认只显示提交ID和提交信息的第一行
2. --decorate, 显示指向提交的所有引用(比如说分支、标签等)
git log --oneline --decorate
3. Diff
git log 提供了很多选项来显示两个提交之间的差异, 最常用的是 --stat 和 -p
--stat, 显示每次提交的文件增删数量
-p, 每次提交删改的绝对数量
当输出所有删改时，想查找某一具体的改动, 使用 pickaxe选项
4. Shortlog
git shortlog 是一种特殊的 git log, 它把每个提交按作者分类, 显示提交信息的第一行
默认情况下, git shortlog 把输出按作者名字排序, 使用-n选项来按每个作者提交数量排序
5. Graph
--graph, 绘制一个ASCII图像来展示提交历史的分支结构
常和 --oneline, --decorate 两个选项一起使用

## 自定义格式
可以使用 --pretty=format:"<string>" 选项, 它允许使用像printf一样的占位符来输出提交
git log --pretty=format:"%cn committed %h on %cd"
%cn, %h, %cd 这三种占位符会被分别替换为作者名字, 缩略标识, 提交日期


# 过滤提交历史

1. 按数量
-<n> 选项, 限制显示的提交数量
git log -3  //显示最新的3次提交
2. 按日期 (--since, --until 标记和 --after, --before 标记分别是等价的)
git log --after="2018-7-1"  //显示2018年7月1日后(含)的提交
git log --after="yesterday"  //显示昨天的提交
git log --after="2018-7-1" --before="2018-7-7"
3. 按作者
--author, 它接受正则表达式, 返回所有作者名字满足这个规则的提交
git log --author="John"
git log --author="John\|Mary"
作者的邮箱地址也算做是作者的名字, 也可以用这个选项按邮箱检索
如果你的工作流区分提交者和作者, --committer也能以相同的方式使用
4. 按提交信息
--grep, 搜索提交信息
git log --grep="JRA-224"
5. 按文件
显示某个特定文件的历史
git log -- foo.py bar.py
--告诉git log接下来的参数是文件路径而不是分支名, 如果分支名和文件名不可能冲突, 可以省略--
6. 按内容
可以根据源代码中某一行的增加或删除来搜索提交, 这被称为pickaxe, 它接受形如 -S"<string>" 的参数
git log -S "Hello, World!"
如果你想用正则表达式而不是字符串来搜索, 你可以使用 -G"<regex>" 标记
7. 按范围
git log <since>..<until>
这个命令在你使用分支引用作为参数时特别有用, 这是显示两个分支之间区别最简单的方式, 看看下面这个命令:
git log master..feature
其中的 master..feature 范围包含了在 feature 分支而不在 master 分支中所有的提交, 换句话说，这个命令可以看出从 master 分支 fork 到 feature 分支后发生了哪些变化
8. 过滤合并提交
git log --no-merges  //排除合并提交
git log --merges  //只显示合并提交

