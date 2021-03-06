# 在kubernetes中使用lxcfs

kubernetes提供了Initializer扩展机制，可以用于对资源创建进行拦截和注入处理，可以借助它优雅地完成对lxcfs文件的自动化挂载。

其manifest文件如下：
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: lxcfs-initializer-default
  namespace: default
rules:
- apiGroups: ["*"]
  resources: ["pods"]
  verbs: ["initialize", "update", "patch", "watch", "list"]
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: lxcfs-initializer-service-account
  namespace: default
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: lxcfs-initializer-role-binding
subjects:
- kind: ServiceAccount
  name: lxcfs-initializer-service-account
  namespace: default
roleRef:
  kind: ClusterRole
  name: lxcfs-initializer-default
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: apps/v1
kind: Deployment
metadata:
  initializers:
    pending: []
  labels:
    app: lxcfs-initializer
  name: lxcfs-initializer
spec:
  replicas: 1
  selector:
    matchLabels:
      app: lxcfs-initializer
  template:
    metadata:
      labels:
        app: lxcfs-initializer
    spec:
      serviceAccountName: lxcfs-initializer-service-account
      containers:
        - name: lxcfs-initializer
          image: registry.cn-hangzhou.aliyuncs.com/denverdino/lxcfs-initializer:0.0.4
          imagePullPolicy: Always
          args:
            - "-annotation=initializer.kubernetes.io/lxcfs"
            - "-require-annotation=true"
---
apiVersion: admissionregistration.k8s.io/v1alpha1
kind: InitializerConfiguration
metadata:
  name: lxcfs.initializer
initializers:
  - name: lxcfs.initializer.kubernetes.io
    rules:
      - apiGroups:
          - "*"
        apiVersions:
          - "*"
        resources:
          - pods
```

如果新建的deployment中包含initializer.kubernetes.io/lxcfs为true的注释，就会对该应用中容器进行文件挂载。
