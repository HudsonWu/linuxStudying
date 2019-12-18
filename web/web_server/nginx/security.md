# security

## 访问限制

```
## 用户的IP地址: $binary_remote_addr, 作为Key, 每个IP地址最多有50个并发连接
## 超过50个连接, 直接返回503错误
limit_conn_zone $binary_remote_addr zone=TotalConnLimitZone:10m ;
limit_conn  TotalConnLimitZone  50;
limit_conn_log_level notice;

## 用户的IP地址: $binary_remote_addr, 作为Key, 每个IP地址每秒处理10个请求
limit_req_zone $binary_remote_addr zone=ConnLimitZone:10m  rate=10r/s;
limit_req_log_level notice;

## 具体服务器配置
server {
    listen   80;
    location ~ \.php$ {

        ## 最多5个排队, 由于每秒处理10个请求+5个排队, 
        ## 你一秒最多发送15个请求过来, 再多就直接返回503错误
        limit_req zone=ConnLimitZone burst=5 nodelay;

        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        include fastcgi_params;
    }   

}
```

## 允许和禁用指定ip或网段

```
location /secure_path {
  deny 192.168.1.8;
  allow 192.168.1.0/24;
  allow 10.1.1.0/16;
  deny all;
}
```

上面的配置实现的效果如下：
  + 如果访问源是192.168.1.8的主机，请求/secure_path，返回403
  + 如果访问源是192.168.1.0/24或10.1.1.0、16网段内的主机，允许访问
    + 虽然这里的网段内包含192.168.1.8，但按顺序来，它在第一条已经被拒绝了
  + 拒绝其他任何ip对/secure_path的访问

## CDN环境下安全配置

```
## 这里取得原始用户的IP地址
map $http_x_forwarded_for  $clientRealIp {
    ## 没有通过代理, 直接用remote_addr
    ""  $remote_addr;
    ## 用正则匹配, 从x_forwarded_for中取得用户的原始IP
    ~^(?P<firstAddr>[0-9\.]+),?.*$  $firstAddr;
}

## 针对原始用户IP地址做限制
limit_conn_zone $clientRealIp zone=TotalConnLimitZone:20m ;
limit_conn  TotalConnLimitZone  50;
limit_conn_log_level notice;

## 针对原始用户IP地址做限制
limit_req_zone $clientRealIp zone=ConnLimitZone:20m  rate=10r/s;
#limit_req zone=ConnLimitZone burst=10 nodelay;
limit_req_log_level notice;

## 具体服务器配置
server {
    listen   80;
    location ~ \.php$ {
        ## 最多5个排队, 由于每秒处理10个请求+5个排队, 
        ## 你一秒最多发送15个请求过来, 再多就直接返回503错误
        limit_req zone=ConnLimitZone burst=5 nodelay;

        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        include fastcgi_params;
    }   
}
```
