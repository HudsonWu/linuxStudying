# [fcgiwrap](https://github.com/gnosek/fcgiwrap)

## CGI、FastCGI

CGI(通用网关接口)和 FastCGI(快速通用网关接口)都是语言无关的协议, FastCGI(简称 FCGI)是 CGI 的增强版本, FCGI 可以简单的理解为 CGI + 多进程模型. FCGI 的工作模式有点类似于 Nginx, 一个 Master 进程和多个 Worker 进程. Master 进程主要用来监控 Worker 进程的运行情况, 当某个 Worker 进程意外退出时, Master 进程会随即启动一个新的 Worker 进程；Worker 进程则是真正干活的进程, 用来执行 CGI 程序(传递环境变量、标准输入), 获取 CGI 程序的标准输出, 再将其返回为 Web 服务器(如 Apache、Nginx). Worker 进程处理完请求后不会结束运行, 而是继续等待下一个请求的到来, 直到我们手动关闭它们

+ 对于 PHP: 只建议使用 PHP-FPM, 因为这是官方的解决方案, 性能和稳定性肯定是最好的
+ 对于其它 CGI 程序: 如 Shell、Perl、C/C++, 使用 fcgiwrap, 这是一个通用的 FCGI 管理器

## 安装

```
# 安装 epel 源
yum -y install epel-release

# 安装 fcgi 依赖
yum -y install fcgi fcgi-devel

# 编译 fcgiwrap
git clone https://github.com/gnosek/fcgiwrap
cd fcgiwrap
autoreconf -i
./configure
make
make install
```

## 运行

查看帮助信息:
```console
$ fcgiwrap -h
Usage: fcgiwrap [OPTION]
Invokes CGI scripts as FCGI.

fcgiwrap version 1.1.0

Options are:
 -f            Send CGI's stderr over FastCGI
 -c <number>        Number of processes to prefork
 -s <socket_url>    Socket to bind to (say -s help for help)
 -h            Show this help message and exit

 Report bugs to Grzegorz Nosek <root@localdomain.pl>.
 fcgiwrap home page: <http://nginx.localdomain.pl/wiki/FcgiWrap>
```

运行:
```
# 启动 4 个 worker 进程
nohup fcgiwrap -f -c 4 -s unix:/run/fcgiwrap.socket </dev/null &>/dev/null &

# 修改 socket 文件的 owner
chown nginx:nginx /run/fcgiwrap.socket
```

配置Nginx:
```
server {
    listen      80;
    server_name www.test.org;
    root        /srv/http/www.test.org;
    index       index.html index.cgi;

    location ~* \.cgi$ {
        fastcgi_pass    unix:/run/fcgiwrap.socket;
        fastcgi_param   SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include         fastcgi_params;
    }
}
```

重载nginx:
```
nginx -t  # check nginx config
systemctl reload nginx.service
systemctl status nginx.service
```

测试fcgiwrap:
进入 /srv/http/www.test.org 目录, 创建 index.cgi, 这里使用 shell 脚本, 内容如下: 
```
#!/bin/bash
printf "Content-Type: text/plain; charset=utf-8\r\n"
printf "\r\n"
printf "hello, world!\n"
```
添加可执行权限, 修改所属用户及所属组: `chmod +x *.cgi`、`chown nginx:nginx *.cgi`, 测试: 
```
$ curl 127.0.0.1      
hello, world!
```
