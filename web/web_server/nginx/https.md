# http访问强制转到https

```
# 使用rewrite, nginx早前的写法
rewrite ^(.*)$ https://$host$1 permanent;

# nginx最新支持的写法
return 301 https://$server_name$request_uri;

# 多域名
if ($host ~* "^example.com$") {
  rewrite ^/(.*)$ https://$host/ permanent;
}

# 采用nginx的497状态码
# 497, normal request was sent to HTTPS
# 当网站只允许https访问时, 当用http访问时nginx会报497错误码
# 利用error_page命令将497状态码的链接重定向
error_page 497 https://$host$uri$args;

# 利用meta的刷新作用将http跳转到https
# index.html
<html>
  <meta http-equiv="refresh" content="0;url=https://dev.example.com/">
</html>

# 通过proxy_redirect
proxy_redirect http:// https://;
```

## examples

```
# cat exam.conf
server {
  listen 80;
  server_name exam.who.com;
  index index.html index.php index.htm;

  access_log logs/access.log;
  error_log logs/error.log;

  return 301 https://$server_name$request_uri;

  location ~ / {
    root /data/nginx/html;
    index index.html index.php index.htm;
  }
}

# cat ssl-exam.conf
upstream tomcat8 {
  server 172.29.34.33:8080 max_fails=3 fail_timeout=30s;
}

server {
  listen 443;
  server_name exam.who.com;
  ssl on;

  # ssl log files
  access_log logs/ssl-access.log;
  error_log logs/ssl-error.log;

  # ssl cert files
  ssl_certificate ssl/exam.cer;
  ssl_certificate_key ssl/exam.key;
  ssl_session_timeout 5m;

  location / {
    proxy_pass http://tomcat8/exam/;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto https;
    proxy_redirect off;
  }
}
```
