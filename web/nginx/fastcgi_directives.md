# fastcgi模块主要指令

## `fastcgi_pass`, 指定fastcgi服务器地址

```
用法一: TCP套接字
fastcgi_pass 主机名:端口号;

fastcgi_pass 127.0.0.1:9000;

用法二: UNIX套接字
fastcgi_pass unix:socket连接地址;

fastcgi_pass unix:/tmp/fastcgi.socket

用法三: 区块(upstream区块)
fastcgi_pass 区块名;

定义区块
upstream webserver {
  server 192.168.18.101;
  server 192.168.18.102;
  server 192.168.18.103;
}
使用区块
fastcgi_pass webserver;
```

## `fastcgi_index`, 指定fastcgi索引

```
fastcgi_index index.php;
```

## `fastcgi_param`, 允许传递给fastcgi服务器的请求中的参数

```
用法: fastcgi_param 参数 参数值

SCRIPT_FILENAME和QUERY_STRING, 这两个参数是必须的
```

/usr/local/nginx/conf/fastcgi.conf文件, 可以查看nginx中默认的参数
```
fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;        #脚本文件地址
fastcgi_param  QUERY_STRING       $query_string;                             #查询字符串
fastcgi_param  REQUEST_METHOD     $request_method;                           #请求方式(如GET/POST)
fastcgi_param  CONTENT_TYPE       $content_type;                             #请求的文件的内容类型
fastcgi_param  CONTENT_LENGTH     $content_length;                           #请求的文件的大小
fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;                      #请求的文件名称(相对于根目录而言的文件路径及文件名)
fastcgi_param  REQUEST_URI        $request_uri;                              #请求的URI
fastcgi_param  DOCUMENT_URI       $document_uri;                             #根目录访问URI
fastcgi_param  DOCUMENT_ROOT      $document_root;                            #根目录地址
fastcgi_param  SERVER_PROTOCOL    $server_protocol;                          #服务协议类型
fastcgi_param  HTTPS              $https if_not_empty;                       #是否启用HTTPS服务
fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;                                   #网关接口协议
fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;                      #软件版本
fastcgi_param  REMOTE_ADDR        $remote_addr;                              #访问者IP地址
fastcgi_param  REMOTE_PORT        $remote_port;                              #访问者端口
fastcgi_param  SERVER_ADDR        $server_addr;                              #服务器IP地址
fastcgi_param  SERVER_PORT        $server_port;                              #服务器端口号
fastcgi_param  SERVER_NAME        $server_name;                              #服务器名称(如域名)
# PHP only, required if PHP was built with --enable-force-cgi-redirect
fastcgi_param  REDIRECT_STATUS    200;                                       #状态码
```
在php可打印出上面的服务环境变量, 如: `echo $_SERVER['REMOTE_ADDR']`

## `fastcgi_connect_timeout`, 定义服务器连接超时时间(单位为秒, 默认为60秒)

```
用法: fastcgi_connect_timeout 60s;
```

## `fastcgi_send_timeout`, 发送数据到服务器的超时时间

```
用法: fastcgi_send_timeout 60s;
```

## `fastcgi_split_path_info`, 以pathinfo模式分隔uri

```
用法: fastcgi_split_path_info 模式

fastcgi_split_path_info ^(.+.php)(.*)$

如果uri为: http://www.shixinke.com/index.php/page/1, 通过这个指令会影响两个变量:
$fastcgi_script_name  实际的文件名, 如上面uri中的index.php
$fastcgi_path_info  uri中脚本名之后的部分, 如上面uri中的page/1
这些参数我们可以进一步使用:
fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
fastcgi_param PATH_INFO $fastcgi_path_info
```

## `fastcgi_buffer_size`, 定义缓冲区大小

```
用法: fastcgi_buffer_size 大小;

fastcgi_buffer_size 4k;
```

## `fastcgi_buffers`, 定义缓冲区的数量与大小

```
用法: fastcgi_buffers 数量 大小;

fastcgi_buffers 8 4k;
```
