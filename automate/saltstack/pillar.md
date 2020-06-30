# pillar

```
# 清除pillar缓存
salt '*' saltutil.refresh_pillar

# 获取所有pillar数据
salt '*' pillar.items
```

## 引用pillar的方式

```
# pillar文件中引用
## pillar关键字
{{ pillar['dev_user']['name'] }}
## salt关键字
{{ salt['pillar.get']('dev_user:name', 'defaultuser') }}

# salt命令行中引用
salt '*' state.sls user saltenv=development \
    pillar='{"qa_user": "qa-deploy-user"}'
```

## modular and reusable

```
# 使用include引用state
include:
  - sls1
  - dir.sls2
```
