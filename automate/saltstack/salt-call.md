# masterless minion

salt有一种配置方式允许minion运行在没有master的模式下，这种情况下minion充当自己的master。

```
# 修改minion配置
# /etc/salt/minion文件或者/etc/salt/minion.d/file_client.conf文件
# 修改配置文件会使salt master不能再连接此minion, 慎用
file_client: local
# 执行salt-call命令
salt-call state.sls statename

# 不更改配置文件
salt-call --local state.sls statename
```
