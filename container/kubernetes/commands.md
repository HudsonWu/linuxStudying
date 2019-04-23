# kubectl 常用命令

## patch

> 容器运行时, 直接对容器进行修改的方式

```
kubectl patch pod rc-nginx-2-kpiqt -p '{"metadata":{"labels":{"app":"nginx-3"}}}'
```

## rolling-update

> 不中断业务的更新方式, 每次启动一个新的pod, 等新的pod完全启动后删除一个旧的pod
> rolling-update需要确保新的版本有不同的name, version和label

```
kubectl rolling-update rc-nginx-2 -f rc-nginx.yaml
kubectl rolling-update rc-nginx-2 --rollback  # 回滚
```

## cp

> 用于pod和外部的文件交换

```
kubectl cp mysql-478535978-1dnm2:/tmp/message.log message.log
kubectl cp message.log mysql-478535978-1dnm2:/tmp/message.log
```

## cluster-info

```
kubectl cluster-info
```

## cordon, drain, uncordon

> 保证维护节点时, 平滑地将维护节点上的业务迁移到其他节点上, 保证业务不受影响

> cordon, node坏掉时, 使用cordon标记node不可用, 使用uncordon解除限制
> drain命令用于对某个node进行设定, 执行drain命令后, 会做两件事: 
  > 1. 设定node不可用 (cordon)
  > 2. evict (驱逐, 回收) 其上的pod

```
kubectl cordon 192.168.32.134
kubectl uncordon 192.168.32.134
kubectl drain 192.168.32.134
```
