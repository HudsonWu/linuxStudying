## 一些有用的命令

1. 获取公网ip
```
curl -s http://ip.cn
curl -s http://ip.sb
```

2. http请求
```
curl -X POST -H "Accept: application/json" -H "Content-Type: application/x-www-form-urlencoded" \
-F "email=admin@admin.com" -F "password=admin" -F "=" "http://api.domain.develop/v2/register"

curl -X GET -H "Accept: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI..." \
"http://api.domain.develop/v1/users"
```

3. 监控

```
# 开启gzip请求
curl -I http://www.sina.com.cn/ -H Accept-Encoding:gzip,defalte

# 监控网页的响应时间
curl -o /dev/null -s -w "time_connect: %{time_connect}\ntime_starttransfer: %{time_starttransfer}\ntime_total: %{time_total}\n" "http://www.kklinux.com"

# 监控站点可用性
curl -o /dev/null -s -w %{http_code} "http://www.kklinux.com"
```
