## supervisorctl

有两种用法, 一种是命令式, 一种是交互式

### 命令式

```
1. 查询各进程运行状态
supervisorctl status

2. 启动、停止、重启业务进程, memcached为进程名
supervisorctl start memcached
supervisorctl stop memcached
supervisorctl restart memcached

3. 重启所有属于名为groupworker这个分组的进程
supervisorctl restart groupworker

4. 启动、停止、重启所有进程(不会载入最新的配置文件)
supervisorctl start all
supervisorctl stop all
supervisorctl restart all

5. 重新加载配置文件, 停止原有进程并按新的配置重启所有进程
(注意:所有进程会停止并重启, 线上操作慎重)
supervisorctl reload

6. 根据最新的配置文件, 启动新配置或有改动的进程, 配置没有改动的进程不受影响
(注意:这是线上可以操作的命令, 不会重启原有进程)
supervisorctl update
(注意:显示状态为stop的进程, 用reload或update都不会自动重启)
```
