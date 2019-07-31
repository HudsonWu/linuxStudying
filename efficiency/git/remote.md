# git 远程仓库

## git remote

```
1. 添加上游仓库
git remote add <name> <url>
> git remote add origin git@github.com:username/project.git

2. 查看所有上游仓库名字和git地址
git remote -v

3. 删除上游仓库
git remote rm <name>
> git remote rm origin

4. 保持与上游仓库的同步
git fetch <name> <branch>  //更新指定remote下的分支
git remote update  //更新所有
git fetch --all  //更新所有

5. 推送本地更改到上游
git push -u <name> <branch>

6. git push 推送到两个远程仓库
# 修改.git/config文件
[remote "origin"]
  url = git@github.com:someone/someproject.git
  url = git@git.oschina.net:someone/someproject.git
  fetch = +refs/heads/*:refs/remotes/origin/*
> git push origin master
# 使用git remote set-url命令
> git remote set-url --add origin git@git.oschina.net:someone/someproject.git
```

## git fetch 和 git pull

```
1. git fetch 从远程获取最新版本到本地，但不会自动merge
git fetch origin
git merge origin/dev
2. git pull 从远程获取最新版本并merge到本地
git pull origin dev
```

## git初始提交

```
echo "# ui_automated_testing" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/HudsonWu/ui_automated_testing.git
git push -u origin master
```

## 推送到远程时文件忽略

```
.gitignore文件, 用于设置公共需要排除的文件
.git/info/exclude文件, 用于设置本地需要忽略的文件
```

## 清理无效的远程追踪分支

1. 在本地创建远程追踪分支

在使用git进行版本控制时, 经常会创建一些特性分支方便产品功能的开发和迭代, 在远程版本库创建了一个分支后, 在本地执行以下命令
```console
$ git remote update
Fetching origin
remote: Counting objects: 38, done.
remote: Compressing objects: 100% (26/26), done.
remote: Total 38 (delta 15), reused 25 (delta 12)
Unpacking objects: 100% (38/38), done.
From http://github.com/someone/myproject
   4fc7cf1..27c08df  EHS_System -> origin/EHS_System
   f849d0d..e7fa24a  dev        -> origin/dev
 * [new branch]      test       -> origin/test
```

2. 查看哪些分支需要清理

如果在远程版本库上删除了某一分支, 可以使用以下命令查看
```console
$ git remote prune origin --dry-run
Pruning origin
URL: http://github.com/someone/myproject.git
 * [would prune] origin/20180808
 * [would prune] origin/20180816
 * [would prune] origin/20180827
 * [would prune] origin/20180830
```

3. 删除本地版本库上失效的远程追踪分支

```console
$ git remote prune origin
Pruning origin
URL: http://github.com/someone/myproject.git
 * [pruned] origin/20180808
 * [pruned] origin/20180816
 * [pruned] origin/20180827
 * [pruned] origin/20180830
```
这里的远程追踪分支位于`.git/refs/remote/origin`下, 如果有本地分支作为下游存在的话, 还需要手动清理

4. 查看本地分支中无效的远程追踪
```
$ git branch -vv
```
无效的远程追踪分支会以gone来标识
