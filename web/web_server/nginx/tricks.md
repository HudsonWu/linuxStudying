# 一些实用的例子

## 健康检查

```
location /healthz {
  access_log off;
  return 200 "health\n";
  add_header Content-Type text/plain;
}
```

## 根据二级路径映射不同的服务器

```
location /path1/ {
    proxy_pass http://srv1/;
}

location /path2/ {
    proxy_pass http://srv2/;
}

location / {
    return 403;
}
```

`proxy_pass`配置的地址尾部有`/`时，会将请求路径中匹配到location的部分去掉，剩余部分追加到配置地址中。

```
location /path3 {
    proxy_pass http://srv3;
}
```

`proxy_pass`配置的地址没有路径时，会将请求路径全部追加到配置地址中。

## rewrite的一些用法

```
# 重定向到其他域名
rewrite ^(.*)$ https://other.site.server$1 permanent;

# 根据二级路径映射不同的路由器 (break)
location /path1 {
    rewrite ^/path1/?(.*)$ /$1 break;
    proxy_pass http://srv1;
}

# 重写路径 (last, location内)
location /path1 {
    rewrite ^/path1(.*)$ /path2$1 last;
}
location /path2 {
    proxy_pass http://srv2;
}

# 重写路径 (location外)
location /path1 {
    proxy_pass http://srv1;
}
location /path2 {
    proxy_pass http://srv2;
}
rewrite ^/path1(.*)$ /path2$1 last;
# rewrite ^/path1(.*)$ /path2$1 break;
```

