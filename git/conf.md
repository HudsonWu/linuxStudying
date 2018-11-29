## 配置文件

### 配置文件的分级
git 配置文件分为三级, 三者的使用优先级以离目录最近为原则

+ 系统级(--system)
    + /etc/gitconfig, 该配置对系统上所有用户及他们所拥有的仓库都生效
+ 用户级(--global)
    + ~/.gitconfig, 该配置对当前用户的所有仓库生效
+ 目录级(--local)
    + .git/config, 该配置只对当前仓库生效

### 修改分支的追踪关系
<pre>
[remote "origin"] 
这一项修改对应远程仓库地址

[branch "master"] 
这一项修改本地分支'master'的远程追踪关系分支
如修改merge = refs/heads/master为merge = refs/heads/dev
</pre>

## git config 命令
<pre>
1. 显示当前git配置
> git config --list
2. 编辑git配置文件
> git config -e [--global]
3. 设置提交代码时的用户信息
> git config [--global] user.name "[name]"
> git config [--global] user.email "[email address]"
4. 设置编辑器
git config --global core.editor vim
5. git设置连接方式（https或ssh）
git remote -v
git remote set-url origin git@github.com...
</pre>

## 记住用户名和密码
1. 设置上游仓库时设置用户名和密码
git remote set-url origin https://username:password@github.com/username/project.git
2. 设置密码存储
git config --global credential.helper store  //长期存储密码
git config --global credential.helper cache  //记住密码(默认15min)
git config credential.helper 'cache --timeout=3600'  //自定义存储时间
3. .git/config文件
[credential]
  helper=store

## 一些使用的命令
<pre>
1. 缩写, 别名
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
</pre>

## 对于本地频繁更改但不需要每次都提交的文件
<pre>
1. 可以新建一个文件, 在文件名上加以区分然后用 Git 记住, 作为模板文件
比如说实际的配置文件应该叫 database.conf, 在写好模版之后可以更名为 database.conf.example
Git 记录 database.conf.example 但是忽略 database.conf

2. 使用git update-index --assume-unchanged, 
这样git暂时不会理睬你对文件做的修改, 
当你的工作告一段落决定可以提交时, 执行下面的命令重置该标识
git update-index --no-assume-unchanged
于是git只需要做一次更新
</pre>
