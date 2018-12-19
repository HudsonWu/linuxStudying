## git rev-list, 按反向时间顺序列出提交对象

What git rev-list does is to list reachable commits, by walking the commit graph, starting from particular set of starting-points, while applying some set of constraints. The walk itself may be done in a particular order, some commits may be optionally simplified away, you can stop the walk early with --max-count or skip some initial commits with --skip, and after the set of commits is found it can be reversed and/or counted.

```
git rev-list foo bar ^baz
```
means "list all the commits which are reachable from foo or bar, but not from baz".

## git rev-parse, Pick out and massage parameters

git rev-parse is an ancillary plumbing command primarily used for manipulation

One common usage of git rev-parse is to print the SHA1 hashes given a revision specifier. In addition, it has various options to format this output such as --short for printing a shorter unique SHA1.

```
--verify, to verify that the specified object is a valid git object
--git-dir, for displaying the abs/relative path of the .git directory
--is-inside-git-dir, checking if you're currently within a repository
--is-inside-work-tree, checkint if you're currently within a work-tree
--is-bare-repository, checking if the repo is a bare
```

## git show-ref, 在本地存储库中列出引用

显示本地存储库中可用的引用以及关联的提交ID

```
git show-ref master  //显示master分支的引用
git show-ref --verify refs/heads/dev  //验证并返回dev分支的引用,  --verify需要一个确切的路径
git show-ref --tags  //仅显示标签
git show-ref --heads  //仅显示正确的分支头
```

## git symbolic-ref, 读取, 修改和删除符号引用

```
git symbolic-ref [-m <reason>] <name> <ref>
git symbolic-ref [-q] [--short] <name>
git symbolic-ref --delete [-q] <name>

示例:
git symbolic-ref "first" "refs/heads/master"
```

```
选项:
-d, --delete, 删除符号ref <name>
-q, --quiet, 如果<name>不是符号引用, 而是分离的HEAD, 则不要发出错误消息, 而是静静地退出
--short, 显示refs的缩短值, 如refs/heads/master显示成master
-m, 使用<reason>更新<name>的reflog, 仅在创建或更新符号引用时有效
```
