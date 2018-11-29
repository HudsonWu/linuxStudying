1. git pull
<pre>
//获取最新代码到本地, 并自动合并到当前分支
git remote -v  //查询当前远程的版本
git pull origin dev  //拉取远端origin/dev分支并合并到当前分支

//当我们使用pull命令拉取上游分支的最新代码时, 如果本地分支落后于上游分支, 会产生一个新的merge commit多余信息, 建议使用:
git pull --rebase <remote> <branch>
//等同于以下两条命令
git fetch <remote> <branch>
git rebase <remote>/<branch>
</pre>

2. git fetch + merge
<pre>
//获取最新代码到本地, 然后手动合并分支
//额外建立本地分支
git fetch origin dev:dev1  //在本地建立dev1分支, 并下载远端origin/dev分支到dev1分支中
git diff dev1  //查看当前分支和本地dev1分支的版本差异
git merge dev1  //合并本地分支dev1到当前分支
git branch -D dev1  //删除本地分支dev1
</pre>

3. 不额外建立本地分支
<pre>
git fetch origin master  // 获取最新代码到本地
git log -p master..origin/master  // 查看本地master与远端origin/master版本差异
git merge origin/dev  // 合并远端分支origin/dev到当前本地分支
</pre>

4. 撤销 merge
<pre>
1. 使用git reset
git reset --hard [merge前的commit-hash]
2. 使用git revert
git revert -m [要撤销的那条merge的parent number] [merge的commit-hash]
(The -m option specifies the parent number. This is because a merge commit has more than one parent, and Git does not know automatically which parent was the mainline, and which parent was the branch you want to un-merge.)
(Merge: 8989ee0 7c6b236
git revert 8f937c6 -m 1 will get you the tree as it was in 8989ee0, and git revert -m 2 will reinstate the tree as it was in 7c6b236.)
</pre>
