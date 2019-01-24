# git 配置

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

```
[remote "origin"] 
//这一项修改对应远程仓库地址

[branch "master"] 
//这一项修改本地分支'master'的远程追踪关系分支
//如将merge = refs/heads/master改为merge = refs/heads/dev
```

## git config 命令

1. 查看帮助信息
```sh
git help config
```

2. 显示当前git配置
```sh
git config --list
```

3. 编辑git配置文件
```sh
git config -e [--global]
```

4. 设置提交代码时的用户信息
```sh
git config [--global] user.name "[name]"
git config [--global] user.email "[email address]"
```

5. 设置编辑器
```sh
git config --global core.editor vim
```

6. git设置连接方式（https或ssh）
```sh
git remote -v
git remote set-url origin git@github.com...
```

### 记住用户名和密码

1. 设置上游仓库时设置用户名和密码
```sh
git remote set-url origin https://username:password@github.com/username/project.git
```

2. 设置密码存储
```sh
git config --global credential.helper store  //长期存储密码
git config --global credential.helper cache  //记住密码(默认15min)
git config credential.helper 'cache --timeout=3600'  //自定义存储时间
```

3. .git/config文件
```
[credential]
  helper=store
```

### 配置git push策略

+ nothing, 什么都不干, 估计只是测试用的
+ matching, 匹配所有分支, git 1.x的默认参数, 没有指定分支时, 将push所有本地分支到远程对应匹配的分支
+ simple, 匹配单个分支, git 2.x的默认参数, 没有指定分支时, 只有当前分支会被push到远程
+ upstream/tracking, 当本地分支有upstream时, push到对应的远程分支
+ current, 把当前的分支push到远程的同名分支

1. `tracking`是`upstream`的别名, 但已经被标记为deprecated
2. `simple`和`upstream`一样, 但不允许将本地分支提交到远程不一样名字的分支

```sh
git config --global push.default simple
```

## tips

```
//缩写, 别名
git config --global alias.lg "log --color --graph --pretty=\ 
format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\ 
--abbrev-commit"
```

