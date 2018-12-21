# Docker容器日志查看和清理

容器日志一般存放路径: /var/lib/docker/containers/container_id/ <br/>

## 查看各个日志文件大小, docker_log_size.sh <br/>

```sh
!/bin/bash

echo "===== docker containers logs file size ====="

logs=$(find /var/lib/docker/containers/ -name *-json.log)

for log in $logs
    do
        ls -lh $log
    done

 chmod +x docker_log_size.sh
 ./docker_log_size.sh
```

## 清理Docker容器日志

如果docker容器正在运行, 使用rm -rf删除文件, 将会从文件系统的目录结构上解除链接(unlink), <br/>
如果文件是被打开的(有一个进程正在使用), 那么进程仍然可以读取该文件, 磁盘空间也一直被占用, <br/>
使用cat /dev/null > *-json.log命令, 可以删除文件, 且立即释放磁盘空间<br/>
clean_docker_log.sh <br/>
```sh
!/bin/bash

echo "===== start clean docker containers logs ====="

logs=$(find /var/lib/docker/containers/ -name *-json.log)

for log in $logs
    do
        echo "clean logs: $log"
        cat /dev/null > $log
    done

echo "===== end clean docker containers logs ====="
```

## 设置Docker容器日志大小

1. 设置一个容器服务的日志大小上限

通过配置容器docker-compose的max-size选项<br/>

```
nginx:
  image: nginx:1.12.1
  restart: always
  logging:
    driver: "json-file"
    options:
      max-size: "5g"
```
重启容器后, 其日志大小就被限制在5GB

2. 全局设置

新建或修改/etc/docker/daemon.json, 设置log-driver和log-opts参数<br/>
设置的日志大小, 只对新建的容器有效<br/>
```
{
  "registry-mirrors": ["http://f613ce8f.m.daocloud.io"],
  "log-driver": "json-file",
  "log-opts": {"max-size": "500m", "max-file": "3"}
}
```
容器有三个日志: id+.json, id+1.json, id+2.json, 容器日志大小上限500M <br/>
```
//重启docker守护进程
systemctl daemon-reload
systemctl restart docker
```
