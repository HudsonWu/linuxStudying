# ingress的各种用法

```
# 重定向到其他域名
nginx.ingress.kubernetes.io/permanent-redirect: https://www.google.com

# 重写
nginx.ingress.kubernetes.io/rewrite-target: /$2

# 取消ssl重定向
nginx.ingress.kubernetes.io/ssl-redirect: "false"

# 请求限制
nginx.ingress.kubernetes.io/limit-rps: "50"
nginx.ingress.kubernetes.io/limit-whitelist: "192.168.11.20/24,8.8.8.8"
```

## 一个实例

```
apiVersion: extensions/v1beta
kind: Ingress
metadata:
  name: benjamin-maynard-io-fe
  annotations:
    ingress.kubernetes.io/ssl-redirect: "true"
    kubernetes.io/tls-acme: "true"
    certmanager.k8s.io/issuer: letsencrypt-prod
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/from-to-www-redirect: "true"
    nginx.ingress.kubernetes.io/configuration-snippet: |
      if ($host = 'www.benjamin.maynard.io' ) {
        rewrite ^ https://benjamin.maynard.io$request_uri permanent;
      }
spec:
  tls:
  - hosts:
    - benjamin.maynard.io
    - www.benjamin.maynard.io
    secretName: benjamin-maynard-io-fe
  rules:
  - host: benjamin.maynard.io
    http:
      paths:
      - path: /
        backend:
          serviceName: benjamin-maynard-io-fe
          servicePort: 80
  - host: www.benjamin.maynard.io
    http:
      paths:
      - path: /
        backend:
          serviceName: benjamin-maynard-io-fe
          servicePort: 80
```
