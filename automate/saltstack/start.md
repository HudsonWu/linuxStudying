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

# 查看salt版本
salt 'minion1' test.versions_report

# 安装包
salt '*' pkg.install cowsay

# 列出网络接口
salt '*' network.interfaces

# 列出grains
salt 'minion*' grains.ls

# state
# state.apply was added in 2015.5
salt 'minion2' state.apply nettools
# if you are using an earlier version
# nettools.sls or nettools/(with init.sls and other sls files)
salt 'minion2' state.sls nettools

# highstate
# calling state.apply with no arguments starts a highstate
salt '*' state.apply
# limit how many systems are updated at once
salt --batch-size 10 '*' state.apply

# refresh salt pillar
salt '*' saltutil.refresh_pillar

# salt pillar on the command line
# override any value that might be set in a salt pillar file
salt '*' state.apply ftpsync pillar='{"ftpusername": "test", "ftppassword": "0ydyfww3giq8"}'

```
