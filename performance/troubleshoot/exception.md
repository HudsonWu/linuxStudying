# 异常处理

## 异常关机

```
# 查找是谁关的机
last reboot
last -x shutdown
last -x | head | tac

# 查找日志
grep -iv ': starting\|kernel: .*: Power Button\|watching system buttons\|Stopped Cleaning Up\|Started Crash recovery kernel' \
  /var/log/messages /var/log/syslog /var/log/apcupsd* \
  | grep -iw 'recover[a-z]*\|power[a-z]*\|shut[a-z ]*down\|rsyslogd\|ups'
```
