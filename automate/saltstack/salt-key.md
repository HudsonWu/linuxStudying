# salt-key

```
# 列出所有key
salt-key -L
# 显示key内容
salt-key -P
# 显示key指纹
salt-key -F

# 接受指定minion的key
salt-key -a salt-minion1
# 接受所有key
salt-key -A

# 删除指定minion的key
salt-key -d salt-minion2.example.com
# 删除所有minion的key
salt-key -D -y

# 生成新的key-pair
salt-key --auto-create --gen-signature
```
