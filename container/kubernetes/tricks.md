# kubectl 的一些有用命令

```
# 获取容器镜像信息
for image in $(kubectl get pods --all-namespaces --output=jsonpath='{..image}')
do
    echo $image
done
```
