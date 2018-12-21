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
