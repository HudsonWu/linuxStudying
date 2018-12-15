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
