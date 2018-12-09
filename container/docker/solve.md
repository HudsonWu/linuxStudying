## 解决实际问题

1. 清理开启失败的容器, 删除none镜像
```
docker stop ${docker ps -a | grep "Exited" | awk '{print $1}'}
docker rm ${docker ps -a | grep "Exited" | awk '{print $1}'}
docker rmi ${docker images | grep "none" | awk '{print $3}'}
```

