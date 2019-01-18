# tips

## git rm

```
//删除工作区文件, 并将这次删除放入暂存区
git rm file1 file2

//停止跟踪指定文件, 但该文件会保留在工作区
git rm --cached file

//删除readme.txt的跟踪, 并且删除本地文件
git rm -f readme.txt 

//改名文件, 并且讲这个改名放入暂存区
git mv file_original file_renamed
```

## git add

```
//监控工作区的状态树, 会把工作时的所有变化提交到暂存区
//包括文件内容修改(modified)以及新文件(new), 但不包括被删除的文件
git add .  //添加当前目录的所有文件到暂存区

//仅监控已经被add的文件(即tracked file)
//会将被修改的文件提交到暂存区, 不会提交新文件(untracked file)
git add -u

git add -A    //git add --all的缩写, 上面两个功能的合集
```

## crlf和lf

```
git config --global core autocrlf true
true  -->  添加文件到仓库时, git 视其为文本文件, 将crlf变成lf
false  -->  line-endings不做转换操作, 文本文件保持原样
input  -->  添加文件到仓库时将crlf变成lf, check代码时也是lf, 在windows系统下不使用这个设置
```

## 对于本地频繁更改但不需要每次都提交的文件

1. 使用模板文件
新建一个文件, 在文件名上加以区分然后用 Git 记住, 作为模板文件

比如说实际的配置文件应该叫 database.conf, 在写好模版之后可以更名为 database.conf.example (如果适用于生产环境可以保存为database.conf.prod)

Git 记录 database.conf.example 但是忽略 database.conf

2. 忽略修改
```
git update-index --assume-unchanged
```
这样git暂时不会理睬你对文件做的修改 
当你的工作告一段落决定可以提交时, 执行下面的命令重置该标识
```
git update-index --no-assume-unchanged
```
这样可以让git在必要的时候提交该文件的更新
