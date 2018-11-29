在本地新建分支并与远程分支关联
> git checkout -b dev  //新建并切换到本地dev分支
> git pull origin dev  //本地分支和远程分支相关联

在本地新建分支并推送到远程
> git checkout -b test
> git push origin test  //远程仓库将新建一个test分支

查看本地和远程版本差异
> git log -p dev..origin/dev

查看分支详细信息
> git branch -vv  //可查看分支与远程分支追踪状态
> git remote -vv  //查看远程仓库信息

