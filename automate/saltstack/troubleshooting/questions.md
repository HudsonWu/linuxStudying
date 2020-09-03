# 常见问题总结

1. 更新pillar数据后，pillar.item <pillar> 和 pillar.items返回的数据不一致

```
# 表现
salt 'minion' pillar.item <pillar> : shows the old value
salt 'minion' pillar.items : shows the actual/new value of
salt-call pillar.item <pillar> on the minion : shows the actual/new value of

# 解决方法
salt 'minion' saltutil.refresh_pillar
```

2. 安装软件时，直接在系统上安装成功，使用salt安装失败

```
# 可能是包名有出入，系统上安装会自动匹配正确的包名
# 可以使用pkg.list_pkgs查看
salt 'minion_name1' pkg.list_pkgs | grep libpq
```
