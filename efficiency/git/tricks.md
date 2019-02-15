# 一些实用技巧

## 提交空目录

1. 目录是空的
在目录下创建`.gitkeep`文件, 然后在项目的`.gitignore`中设置不忽略`.gitkeep`
(`.gitkeep`是一个约定俗成的文件, 并不会带有特殊规则)

2. 目录中已经存在文件
需要首先在根目录中设置`!.gitignore`, 然后在目标目录也创建一个`.gitignore`文件, 在文件中设置:
```
*
!.gitignore
```

## 查看指定分支的某个文件内容

```
git show branch_name:/path/to/file.txt | vim -
```

## 获取当前分支名

```
git symbolic-ref --short -q HEAD
```

## 远程覆盖本地

```
git fetch --all
git reset --hard origin/master
```

## 查看master分支所有提交

```
git rev-list master
//显示前10个
git rev-list master --max-count=10
```

## 只克隆最近一次提交的代码

```
//--depth, 解决内容过多时git clone花费时间长的问题
//depth用于指定克隆深度, 为1即表示只克隆最近一次commit
git clone --depth 1 https:/github.com/someone/example.git

//从--depth 1的限制恢复
git fetch --unshallow
//or
git fetch --depth=2147483547

//拉取指定分支
git remote set-branches origin 'remote_branch_name'
git fetch --depth 1 origin remote_branch_name
git checkout remote_branch_name
```

## 修改最近一次的commit msg

```
git commit --amend
```

## 修改git repo历史提交的author

```
git rebase -i HEAD~n  //表示要修改前n次所有的提交, -i, interactive, 交互
//将需要修改的提交的pick改成edit或e

git commit --amend --author "someone <someone@gmail.com>"

git rebase --continue
```

## 测试ssh是否成功连接

```
ssh -vT git@github.com
```

## git add未commit, reset恢复文件

git add 且未 commit 的文件, 在执行reset --hard后的恢复操作

1. 获取所有悬挂文件
```
//将悬挂的文件存入filex.txt中
git fsck > files.txt
//或者使用下面的命令查看最近60次add的文件
find .git/objects -type f | xargs ls -lt | sed 60q
```
filex.txt文件内容如下:
```
dangling blob 909393bd05bd101c024135d7eb32229104cadc10
dangling blob ceac90d3363acf317e9d063e5fd1604831f0f3e8
dangling blob 9215bdb8098d2a11cc8fb266fb114a430772cd87
```

2. 去掉dangling blob关键字
使用vim处理:
```
:1,$s/dangling blob //g
```

3. 将blob字节文件还原为原文, 这里注意, 文件名称已经丢失, 最终只能通过手动更新文件名称
通过git show 将blob文件还原为对应文件
```sh
#!/bin/bash
for line in `cat files.txt`
do
    echo "File:${line}"
    git show ${line} > files/${line}.txt
done
```

4. 从还原的所有文件中查找需要找回的文件
```
grep "关键字" *.txt
```
