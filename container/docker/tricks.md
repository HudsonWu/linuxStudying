# 一些实用的命令

## 显示所有容器的ip地址

```
docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress}}' $(docker ps -qa)
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
```

## 携带一套工具进入容器内部

```
export TARGET_ID=ed735b2264ac
docker run -it --network=container:$TARGET_ID --pid=container:$TARGET_ID --ipc=container:$TARGET_ID busybox
```
