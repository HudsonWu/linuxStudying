# 限制IP并发连接数和请求数

Nginx限制IP连接数使用的是ngx_http_limit_conn_module模块，可以通过这个模块中的`limit_conn_zone`和`limit_conn`两个参数实现。

Nginx限制请求数使用的是ngx_http_limit_req_module模块，可以通过这个模块中`limit_req_zone`和`limit_req`两个参数实现。

## ngx_http_limit_conn_module

### limit_conn_zone

用于定义一个zone，该zone将会被用于存储会话状态，能够存储的会话数量由定义的size大小和系统参数memory_max_size大小决定。

+ 语法: limit_conn_zone key zone=name:size;
+ 默认值: none
+ 配置段: http

实例：
```
# $binary_remote_addr, 二进制的ip地址，就是客户端的来源ip
limit_conn_zone $binary_remote_addr zone=conn_ip:10m;

# $server_name，虚拟主机名，如www.exam.com
limit_conn_zone $server_name zone=conn_server:10m;
```
zone是共享内存空间，用于保存每个key对应的连接数，可以按照需求自己定义名字。一个二进制的ip地址在32位机器上占用32个字节，在64位机器上占用63个字节，设置为10m的话，32位机器可以存放3260780个ip地址(10x1024x1024/32)。如果共享内存空间被耗尽，服务器会对后续所有的请求返回503(Service Temporarily Unavailable)错误。

### limit_conn

用于为一个会话设定最大的并发连接数，如果并发请求数超过这个限制，会返回503。

+ 语法: limit_conn zone number;
+ 默认值: none
+ 配置段: http, server, location

实例：
```
# 限制单个ip的连接并发数，此处为10个
limit_conn conn_ip 10;

# 限制某个虚拟服务器的总连接数，此处为1000个
limit_conn conn_server 1000;
```

### limit_conn_log_level

当达到最大限制连接数后，记录日志的等级。

+ 语法: limit_conn_log_level info | notice | warn | error
+ 默认值: error
+ 配置段: http, server, location

### limit_conn_status

该参数在1.3.15版本引入，指定当超过限制时，返回的状态码（默认503），值只能设置在400到599之间。

+ 语法: limit_conn_status code;
+ 默认值: limit_conn_status 503;
+ 配置段: http, server, location

### limit_rate

对每个连接的速率限制，单位是字节/秒，设置为0将关闭限速。按连接限速而不是按IP限制，因此如果某个客户端同时开启了两个连接，那么客户端的整体速率是这条指令设置值的2倍。

+ 语法: limit_rate rate
+ 默认值: 0
+ 配置段: http, server, location, if in location

### 配置示例

```
http {
  include mime.types;
  default_type application/octet-stream;
  sendfile on;
  keepalive_timeout 65;

  limit_conn_zone $binary_remote_addr zone=conn_ip:10m;
  limit_conn_zone $server_name zone=conn_server:10m;
  limit_conn_log_level info;

  server {
    listen 80;
    server_name www.exam.com;
    index index.html index.htm login.html;

    access_log logs/exam_access.log;
    error_log logs/exam_error.log;

    location / {
      root /opt/web/;
      limit_conn conn_ip 10;
      limit_conn conn_server 1000;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
      root /opt/web/error_page/;
    }
  }
}
```

上面的配置实现的效果是：
  + 当某个ip访问www.exam.com这个域名时，如果该ip的并发连接数超过10，则会报503，表示服务暂时不可用
  + 当访问www.exam.com这个域名的连接总数超过1000时，同样会报503，返回定义好的错误页面

测试命令：
```
# 安装ab软件
yum install httpd-tools -y

# 模拟并发访问, -n代表请求数, -c代表并发数
ab -n 10 -c 10 http://www.exam.com
ab -n 11 -c 11 http://www.exam.com

# 服务端监控错误日志
tail -f /opt/nginx/logs/exam_error.log
```

## ngx_http_limit_req_module

### limit_req_zone

利用令牌桶原理，来限制用户的连接频率，通过设置一块共享内存限制域用来保存键值的状态参数，特别是保存了当前超出请求的数量，键的值就是指定的变量（空值不会被计算）。

+ 语法: limit_req_zone $variable zone=name:size rate=rate;
+ 默认值: none
+ 配置段: http

```
limit_req_zone $binary_remote_addr zone=req_ip:10m rate=1r/s;
```

rate=1r/s指每个ip平均处理的请求频率为每秒一次，此值可以设置成每秒处理请求数或者每分钟处理请求数，但必须是整数，如果需要指定每秒处理少于1个的请求，2秒处理一个请求，可以使用30r/m。

### limit_req

设置对应的共享内存限制域和允许被处理的最大请求数阈值，如果请求的频率超过了限制域配置的值，请求处理会被延迟，所以所有的请求都是以定义的频率被处理的。超过频率限制的请求会被延迟，直到被延迟的请求数超过了定义的阈值，这时，这个请求会被终止，并返回503，这个阈值默认为0。

+ 语法: limit_req zone=name [burst=number] [nodelay];
+ 默认值: -
+ 配置段: http, server, location

```
limit_req zone=req_ip burst=5;
```

burst=5指设置一个大小为5的缓冲区，当有大量请求过来时，超过了访问频次限制的请求可以先放到这个缓冲区内，如果此存区也满了则返回503。

如果设置了nodelay参数，超过访问频次而且缓冲区也满了的时候就会直接返回503，如果没有设置，则所有请求会等待排队。

### limit_req_log_level

设置日志级别，当服务器因为频率过高而拒绝或者延迟处理请求时可以记下相应级别的日志。延迟记录的日志级别比拒绝的低一个级别。比如如果设置limit_req_log_level notice，延迟的日志就是info级别。

+ 语法: limit_req_log_level info | notice | warn | error;
+ 默认值: limit_req_log_level error;
+ 配置段: http, server, location

### limit_req_status

该参数在1.3.15版本引入，指当超过限制时，返回的状态码（默认是503），code值只能设置在400到599之间。

+ 语法: limit_req_status code;
+ 默认值: limit_req_status 503;
+ 配置段: http, server, location

### 配置示例

```
http {
  limit_conn_zone $binary_remote_addr zone=conn_ip:10m;
  limit_conn_zone $server_name zone=conn_server:10m;
  limit_req_zone $binary_remote_addr zone=req_ip:10m rate=10r/s;

  server {
    location / {
      limit_conn conn_ip 10;
      limit_conn conn_server 1000;
      limit_req zone=req_ip burst=5;
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
      root html;
    }
  }
}
```
