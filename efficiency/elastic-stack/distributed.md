# 分布式

## 特性

+ 存储的水平扩容，支持PB级数据
+ 提高系统的可用性，部分节点停止服务，整个集群的服务不受影响

## 节点

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

### Master Eligible Nodes

+ 一个集群，支持配置多个Master Eligible节点，
这些节点可以在必要时（如master节点出现故障，网络故障时）
参与选主流程，称为Master节点
+ 每个节点启动后，默认就是一个Master Eligible节点，
可以设置`node.master: false`禁止
+ 当集群内第一个Master Eligible节点启动时，它会将自己选举成Master节点

### Master Eligible Nodes 选主的过程

+ 互相ping对方，Node Id低的会成为被选举的节点
+ 其他节点会加入集群，但是不承担Master节点的角色
+ 一旦发现被选中的主节点丢失，就会选择出新的Master节点

#### 脑裂问题

Split-Brain, 分布式系统的经典网络问题，当出现网络问题时，会出现多个master节点的情况。

如何避免：
  + 限定一个选举条件，设置quorum(仲裁)
    + 只有在Master Eligible节点数大于quorum时，才能进行选举
    + Quorum = (Number of master eligible nodes / 2) + 1
    + 当3个master eligible时，设置`discovery.zen.minimum_master_nodes`为2

7.0开始，无需这个配置：
  + 移除minimum_master_nodes参数，让Elasticsearch自己选择可以形成仲裁的节点
  + 典型的主节点选举现在只需要很短的时间就可以完成，集群的伸缩变得更安全、更容易，
  并且可能造成丢失数据的系统配置选项更少了
  + 节点更清楚地记录它们的状态，有助于诊断为什么它们不能加入集群或为什么无法选举出主节点
  

### Coordinating Node

+ 处理请求的节点，叫Coordinating Node
+ 所有节点默认都是Coordinating Node
+ 通过将其他类型设置成False，使其成为Dedicated Coordinating Node

```
coordinating, 协调
dedicated, 专用，专注的
```

### Data Node

+ 可以保存数据的节点，叫做Data Node
  + 节点启动后，默认就是数据节点，可以设置`node.data: false`禁止
+ Data Node的职责
  + 保存分片数据，在数据扩展上起到至关重要的作用
+ 通过增加数据节点可以解决数据水平扩展和解决数据单点问题

## 集群状态

+ 集群状态信息（Cluster State），维护了一个集群中，必要的信息：
  + 所有节点信息
  + 所有的索引和其相关的Mapping与Setting信息
  + 分片的路由信息
+ 在每个节点上都保存了集群的状态信息
+ 只有Master节点才能修改集群的状态信息，并负责同步给其他节点
