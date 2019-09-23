# sidecar

## 保持容器持续存在

```
# 循环执行命令
command: ["/bin/sh"]
args: ["-c", "while true; do date >> /var/log/app.txt; sleep 5;done"]

# tty
stdin: true
tty: true
```

## 权限

```
securityContext:
  privileged: true
  capabilities:
    add:
    - ALL
```
