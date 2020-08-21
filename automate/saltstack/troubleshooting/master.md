# troubleshooting

+ <https://docs.saltstack.com/en/latest/topics/troubleshooting/master.html>


+ yappi
+ KCachegrind

```
# 调试模式启动
salt-master -l debug

# live salt-master profiling
## 开启
killall -SIGUSR2 salt-master
## 关闭
killall -SIGUSR2 salt-master

# display where in the code they are running
salt-master -l debug
killall -SIGUSR1 salt-master
```
