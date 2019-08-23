# swarm

+ [tutorial](https://docs.docker.com/engine/swarm/swarm-tutorial/)

## setup

```
# manager
192.168.19.48

# port
2377/tcp, cluster management communications
7946/tcp 7946/udp, communication among nodes
4789/udp, overlay network traffic
```

## manager

```
# 创建一个集群
docker swarm init --advertise-addr 192.168.19.48

# 添加worker
docker swarm join --token SWMTKN-1-4p0b0548ow4lp3c2htv3skjoommz80sf7kktaddp3ylugjb3wz-1l3ppd7qnryaye3ofqkv6w0jz 192.168.19.48:2377

# 查看节点信息
docker node ls

# 获取以worker角色加入集群的命令
docker swarm join-token worker

# 获取以manager角色加入集群的命令
docker swarm join-token manager

# 从集群移除节点
## 在该节点主机执行leave命令
docker swarm leave
## 在manager执行rm命令
docker node rm node-2
```
