# 查看系统开机时间

```
date -d "`cut -f1 -d. /proc/uptime` seconds ago"
```
