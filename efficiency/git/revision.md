# Revision, 修订版本

修订版本的选择: Git允许你通过几种方法来指明特定的或者一定范围内的提交

## SHA

Git可以为你的SHA-1值生成简短且唯一的缩写, 如果你传递--abbrev-commit给git log命令, 输出结果里就会使用简短且唯一的值, 它默认使用7个字符来表示, 必要时为避免SHA-1的歧义会增加字符数
```
git log --abbrev-commit --pretty=oneline
```

如果你想知道某个分支指向哪个特定的SHA, 可以使用rev-parse的git探测工具

## 引用日志

在你工作时, git在后台的工作之一就是保存一份引用日志, 一份记录最近几个月你的HEAD和分支引用的日志

```console
$ git reflog  //查看引用日志
734713b HEAD@{0}: commit: commit message 1
ddf777g HEAD@{1}: commit: commit message 2
de56eeg HEAD@{2}: commit: commit message 3
deiur22 HEAD@{3}: commit: commit message 4

$ git show HEAD@{3}  //查看仓库中HEAD在3次前的值

$ git show master@{yesterday}  //查看master分支昨天的值

$ git log -g    //类似git log输出格式的引用日志信息
```
引用日志信息只存在于本地, 这是一个记录你在你自己的仓库里做过什么的日志

## 提交范围

指明一定范围的提交


让git区分出可以从一个引用中获得而不能从另一个引用中获得的提交
```
git log master..experiment  //所有在experiment而不在master中的提交
git log experiment..master  //所有在master而不在experiment中的提交
git log origin/master..HEAD  //显示所有在当前分支而不在远程origin上的提交
git log origin/master..    //git使用HEAD来替代不存在的一边
```

当你想针对两个以上的引用来指明修订版本, 比如想查看哪些提交被包含在某些引用中的一个, 但是不在你当前的引用上. git允许你在引用前使用`^`和`--not`. 下面三条命令等价:
```
git log refA..refB
git log ^refA refB
git log refB --not refA
```

指定两个以上的引用:
```
git log refA refB ^refC
git log refA refB --not refC
```

被两个引用中的一个包含但又不被两者同时包含的提交
```
git log master...experiment
git log --left-right master..experiment  //显示每个提交属于哪一侧引用
```
