# 分布式

## 特性

+ 存储的水平扩容，支持PB级数据
+ 提高系统的可用性，部分节点停止服务，整个集群的服务不受影响

```
1. 不同的集群通过不同的名字来区分，默认名字"elasticsearch"
2. 通过配置文件修改，或者在命令行中-E cluster.name=xxx进行设定
3. 节点是一个elasticsearch的实例，其本质上就是一个JAVA进程
4. 节点名字通过配置文件配置，或者启动时-E node.name=xxx指定
5. 每一个节点启动后，会分配一个UID，保存在data目录下
```

### Master Node

+ 职责
  + 处理创建、删除索引等请求
  + 决定分片被分配到哪个节点
  + 负责索引的创建和删除
  + 维护并更新Cluster State
+ 最佳实践
  + Master节点非常重要，在部署上需要考虑解决单点的问题
  + 为一个集群设置多个Master节点，每个节点只承担Master的单一角色


### Coordinatin Node

处理请求的节点，叫Coordinating Node，
