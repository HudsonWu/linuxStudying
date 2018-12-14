# k8s内部负载均衡原理

[Large-scale cluster management at Google with Borg](https://storage.googleapis.com/pub-tools-public-publication-data/pdf/43438.pdf)

## 几个概念

### Pod

1. Pod是Kubernetes创建或部署的最小/最简单的基本单位
2. Pod的基础架构是由一个根容器Pause Container和多个业务Container组成的
3. 根容器的IP就是Pod IP, 是由Kubernetes从etcd中取出相应的网段分配的, Container IP是由docker分配的, 同样这些IP相对应的IP网段是被存放在etcd里
4. 业务Container暴露出来端口并且映射到相应的根容器Pause Container端口, 映射出来的端口叫做endpoint
5. 业务Container的生命周期就是POD的生命周期, 任何一个与之相关联的Container死亡, Pod也应该随之消失

### Service

1. Service是定义一系列Pod以及访问这些Pod的策略的一层抽象, Service通过Label找到Pod组, 因为Service是抽象的, 所以在图表里通常看不到它们的存在
2. Kubernetes也会分给Service一个内部的Cluster IP, Service通过Label查询到相应的Pod组, 如果你的Pod是对外服务的, 那么还应该有一组endpoint, 需要将endpoint绑定到Service上, 这样一个微服务就形成了

### Kubernetes CNI

CNI(Container Network Interface), 是用于配置Linux容器网络接口的规范和库组成, 同时还包含了一些插件, CNI仅关心容器创建时的网络分配, 和当容器被删除时释放网络资源

### Ingress

1. 俗称边缘节点, 假如你的Service是对外服务的, 那么需要将Cluster IP暴露为对外服务, 这时候就需要将Ingress与Service的Cluster IP与端口绑定起来对外服务, 这样看来其实Ingress就是将外部流量引入到Kubernetes内部
2. 实现Ingress的开源组件有Traefik和Nginx-Ingress, 前者方便部署, 后者部署复杂但是性能和灵活性更好

## 组件

### Kube-Proxy

1. Kube-Proxy是被内置在Kubernetes的插件
2. 当Service与Pod Endpoint变化时, Kube-Proxy将会改变宿主机iptables, 然后配合Flannel或者Calico将流量引入Service

### Etcd

1. Etcd是一个简单的Key-Vaule存储工具
2. Etcd实现了Raft协议, 这个协议主要解决分布式强一致性问题, 与之相似的有Paxos, Raft比Paxos要容易实现
3. Etcd用来存储Kubernetes的一些网络配置和其他的需要强一致性的配置, 以供其他组件使用

[raft相关资料](https://github.com/motecshine/simple-raft)

### Flannel

1. Flannel是CoreOS团队针对Kubernetes设计的一个覆盖网络Overlay Network工具, 其目的在于帮助每一个使用Kubernetes的CoreOS主机拥有一个完整的子网
2. 主要解决POD和Service, 跨节点相互通讯的

### Traefik

1. Traefik是一个使得部署微服务更容易的现代HTTP反向代理、负载
2. Traefik不仅仅是对Kubernetes服务, 除了Kubernetes, 他还有很多的Providers, 如Zookeeper, Docker Swarm, Etcd等
