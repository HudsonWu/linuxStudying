# 安装之后快速上手

## salt-key命令

```
# master端通过key的状态快速知道所有minion的连接情况
salt-key --list-all

# 连接一个minion之前，必须接受minion的key
# 接受一个特定的KEY
salt-key --accept=<key>

# 接受所有keys
salt-key --accept-all
```

## 命令语法

```
salt target module.function arguments
salt '*' pkg.install cowsay
```

## 简单命令

```
# 运行shell命令
salt '*' cmd.run 'ls -l /etc'

# 安装包
salt '*' pkg.install cowsay

# 列出网络接口
salt '*' network.interfaces

# 列出grains
salt 'minion*' grains.ls
```
