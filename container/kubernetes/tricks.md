# kubectl 的一些有用命令

```
# 获取容器镜像信息
for image in $(kubectl get pods --all-namespaces --output=jsonpath='{..image}')
do
    echo $image
done

# 强制删除pod
# grace-period表示过渡存活期, 默认30s
kubectl delete pod yourpodname -n yourns --force --grace-period=0
```
