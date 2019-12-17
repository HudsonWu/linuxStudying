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
