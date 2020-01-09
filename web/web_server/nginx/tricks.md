# 一些实用的例子

```
# 重定向到其他域名
rewrite ^(.*)$ https://other.site.server$1 permanent;
```

## 健康检查

```
location /healthz {
  access_log off;
  return 200 "health\n";
  add_header Content-Type text/plain;
}
```
