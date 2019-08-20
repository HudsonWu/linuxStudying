# ConfigMap

## 添加configmap

```
# 声明为resource
resources:
- configmap.yaml

# 在ConfigMapGenerator中声明ConfigMap
configMapGenerator:
- name: a-configmap
  files:
    - configs/configfile
    - configs/another_configfile
```

## ConfigMapGenerator

```
# files
configMapGenerator:
- name: a-configmap
  files:
    - configs/configfile
    - configs/another_configfile

# literals
configMapGenerator:
- name: the-map
  literals:
    - altGreeting=Good Morning!
    - enableRisky="false"
```

## merge

```
# patchesStrategicMerge
## kustomization.yaml
patchesStrategicMerge:
- map.yaml
## map.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: the-map
data:
  altGreeting: "Have a pineapple!"
  enableRisky: "true"

# merge
## kustomization.yaml
configMapGenerator:
- name: my-configmap
  behavior: merge
  files:
  - plumbing.properties
  - secret.properties
```

## generatorOptions

modify the behavior of ConfigMap and Secret generators

```
generatorOptions:
  disableNameSuffixHash: true
  labels:
    kustomize.generated.resource: somevalue
  annotations:
    annotations.only.for.generated: othervalue
```
