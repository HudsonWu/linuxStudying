# cors

```
# 跨域测试
curl -I -X OPTIONS -H 'Origin: https://www.example2.com' 'https://www.example.com'
```

```
location / {
  set $corsHost '';
  set $httpHeaders 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization,Content-Type,X-Forwarded-For,xfilecategory,xfilename,xfilesize';
  if ($http_origin ~ 'https?://(.*).example.com') {
    set $corsHost $http_origin;
  }
  if ($request_method = 'OPTIONS') {
    more_set_headers 'Access-Control-Allow-Origin: $corsHost';
    more_set_headers 'Access-Control-Allow-Credentials: true';
    more_set_headers 'Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, PATCH';
    more_set_headers 'Access-Control-Allow-Headers: $httpHeaders';
    more_set_headers 'Access-Control-Max-Age: 1728000';
    more_set_headers 'Content-Type: text/plain charset=UTF-8';
    more_set_headers 'Content-Length: 0';
    return 204;
  }
  more_set_headers 'Access-Control-Allow-Origin: $corsHost';
  more_set_headers 'Access-Control-Allow-Credentials: true';
  more_set_headers 'Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, PATCH';
  more_set_headers 'Access-Control-Allow-Headers: $httpHeaders';
}
```

## 允许指定单个域名跨域访问

```
location / {
  add_header 'Access-Control-Allow-Origin' 'https://www.example.com';
  add_header 'Access-Control-Allow-Credentials' 'true';
  add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS';
  add_header 'Access-Control-Allow-Headers' 'Authorization,Content-Type,Accept,Origin,User-Agent,DNT,Cache-Control,X-Mx-ReqToken,X-Requested-With';
  if ($request_method = 'OPTIONS') {
    return 204;
  }
}
```

## 允许多个域名跨域访问

### 使用IF

```
server {
  set $allow_origin "";
  if ( $http_origin ~ '^https?://(www|m).example.com' ) {
    set $allow_origin $http_origin;
  }
  location / {
    add_header 'Access-Control-Allow-Origin' $allow_origin;
    add_header 'Access-Control-Allow-Credentials' 'true';
    add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'Token,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,X_Requested_With,If-Modified-Since,Cache-Control,Content-Type';
    if ($request_method = 'OPTIONS') {
      return 204;
    }
  }
}
```

### 使用MAP

```
map $http_origin $allow_origin {
  default "";
  "~^(https?://localhost(:[0-9]+)?)" $1;
  "~^(https?://127.0.0.1(:[0-9]+)?)" $1; 
  "~^(https?://192.168.10.[\d]+(:[0-9]+)?)" $1; 
  "~^https://www.example.com" https://www.example.com;
  "~^https://m.example.com" https://m.example.com;
  "~^(https?://[\w]+.open.example.com)" $1;
  #"~^(https?://([\w]+.)?[\w]+.open.example.com)" $1;  #允许一级和二级域名
}

server {
  location /{
    add_header 'Access-Control-Allow-Origin' $allow_origin;
    add_header 'Access-Control-Allow-Credentials' 'true';
    add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'Token,DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,X_Requested_With,If-Modified-Since,Cache-Control,Content-Type';
    if ($request_method = 'OPTIONS') {
      return 204;
    }
}
```

## 更多判断

```
location / {
  if ($request_method = 'OPTIONS') {
    add_header 'Access-Control-Allow-Origin' 'https://www.example.com';
    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range';
    add_header 'Access-Control-Max-Age' 1728000; # 20days
    add_header 'Content-Type' 'text/plain; charset=utf-8';
    add_header 'Content-Length' 0;
    return 204;
  }
  if ($request_method = 'POST') {
    add_header 'Access-Control-Allow-Origin' 'https://www.example.com';
    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range';
    add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range';
  }
  if ($request_method = 'GET') {
    add_header 'Access-Control-Allow-Origin' 'https://www.example.com';
    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range';
    add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range';
  }
}
```
