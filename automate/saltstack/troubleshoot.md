# 解决问题的命令

```
# 查看minion的变量
salt '*01' cmd.shell 'echo $LANG'
```

```
# 查看state的内容
salt 'minion01' state.show_sls statename saltenv=envname
# 应用state
salt 'minion01' state.sls statename saltenv=envname
# 使用参数test=True, 测试state而不实际应用到minion
salt 'minion01' state.sls appenv saltenv=development test=True
```

```
# 更改了pillar数据，通常情况下minions会自动识别出更改后的数据
# 使用以下命令查看pillar数据
salt 'minion01' pillar.items
# 如果minions没有更改pillar数据的话，手动刷新
salt 'minion01' saltutil.refresh_pillar
```
