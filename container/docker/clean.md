# 清理docker占用的磁盘空间

## docker system 命令

```
# 查看Docker的磁盘使用情况
docker system df

# 清理磁盘, 删除关闭的容器, 无用的数据卷和网络, 
# 以及dangling镜像(无tag的镜像)
docker system prune
docker system prune -a  # 可以将没有容器使用的Docker镜像都删掉
```

## 手动清理 docker 镜像/容器/数据卷

```
# 删除所有关闭的容器
docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm

# 删除所有dangling镜像
docker rmi $(docker images | grep "<none>" | awk "{print $3}")

# 删除所有dangling数据卷(即无用的volume)
docker volume rm $(docker volume ls -qf dangling=true)
```
