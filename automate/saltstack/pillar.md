# pillar

## 引用pillar的方式

```
# pillar文件
## pillar关键字
{{ pillar['dev_user']['name'] }}
## salt关键字
{{ salt['pillar.get']('dev_user:name', 'defaultuser') }}

# salt命令行
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
