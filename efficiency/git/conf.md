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

## tips

```
//缩写, 别名
git config --global alias.lg "log --color --graph --pretty=\ 
format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\ 
--abbrev-commit"
```

