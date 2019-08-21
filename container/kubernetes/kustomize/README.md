# kustomize

+ [github](https://github.com/kubernetes-sigs/kustomize)

```
# 基本目录结构
~/someApp
|-- base
|    |-- common.properties
|    |-- deployment.yaml
|    |-- kustomization.yaml
|    |-- service.yaml
|__ overlays
   |-- development
   |    |-- plumbing.properties
   |    |-- secret.properties
   |    |-- cpu_count.yaml
   |    |-- kustomization.yaml
   |    |-- replica_count.yaml
   |__ production
        |-- cpu_count.yaml
        |-- kustomization.yaml
        |-- replica_count.yaml

# 多应用
~/apps
|-- patch.yaml
|-- kustomization.yaml
|-- app1
|    |-- kustomization.yaml
|    |-- deployment.yaml
|    |-- service.yaml
|-- app2
|    |-- kustomization.yaml
|    |-- deployment.yaml
|    |-- service.yaml

# multibases
~/someApp
|-- base
|    |-- kustomization.yaml
|    |-- pod.yaml
|-- dev
|    |-- kustomization.yaml (resources: ../base)
|-- kustomization.yaml (resources: ./dev ./staging ./production)
|-- production
|    |-- kustomization.yaml (resources: ../base)
|-- staging
|    |-- kustomization.yaml (resources: ../base)
```

## 变量定义

```
# kustomization.yaml
vars:
  - name: WORDPRESS_SERVCIE
    objref:
      kind: Service
      name: wordpress
      apiVersion: v1
    fieldref:
      fieldpath: metadata.name
```

```
# 更改容器镜像
kustomize edit set image busybox=alpine:3.6
```
