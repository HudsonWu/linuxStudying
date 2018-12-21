## [httpie, http命令行客户端](https://github.com/jakubroztocil/httpie)

## 安装

```
apt-get install httpie
yum install httpie
```

python方式
```
pip install --upgrade httpie
pip install --upgrade https://github.com/jkbrzt/httpie/tarball/master
```

## HTTP请求

1. 默认请求方法

如果不带METHOD参数, 且没有附带请求参数时默认使用GET方法请求; 附带请求参数时, 默认以json格式传输, 默认使用GET方法请求
```
http example.org
http example.org hello=world 
```

2. GET方法

定制头部
```
http tonydeng.github.io/blog/httpie-howto/ User-Agent:Xmodlo/1.0 Refer:http://tonydeng.github.io
```

下载文件
```
http tonydeng.github.io/blog/httpie-howto/ httpie-howto.html
http --download tonydeng.github.io/blog/httpie-howto/
```

3. PUT方法

```
http PUT tonydeng.github.io name='Tony Deng' email='tonydeng@email.com'
```

4. POST方法

```
http -f POST tonydeng.github.io name='Tony Deng' email='tonydeng@email.com'
```
-f选项使http命令序列化数据字段, 并将Content-Type设置为application/x-www-form-urlencoded;charset=utf-8

5. HEAD

```
http HEAD tonydeng.github.io
```

6. JSON支持

HTTPie内置JSON支持, 事实上HTTPie默认使用的Content-Type就是application/json

7. 输入重定向

```
http POST tonydeng.github.io < my_info.json
echo '{"name": "Tony Deng", "email: "tonydeng@email.com"} ' | http POST tonydeng.github.io
```

## 应用实例

1. 默认协议为http://, 如果主机是localhost, 可以简写

```
http :3000  // http://localhost:3000
http :/foo  // http://localhost/foo
```

2. 使用param==value语法向url添加参数

```
http www.google.com search=='HTTPie logo' tbm==isch
```

3. param=value格式的参数全部会转换成json格式传输, 且value全是字符串

```
http PUT example.org name=John email=john@example.org
```

4. 非字符串使用 := =@ :=@

```
http PUT api.example.com/person/1 \
    name=John \
    age:=29 married:=false hobbies:='["http", "pies"]' \ # Raw JSON
    description=@about-john.txt \ # Embed text file
    bookmarks:=@bookmarks.json  # Embed JSON file
```

5. Forms

--form, -f option which ensures that data fields are serialized as, and Content-Type is set to: `application/x-www-form-urlencoded; charset=utf-8`
```
http --form POST api.example.org/person/1 name='John Smith' \
    email=john@example.org cv=@~/Documents/cv.txt
```

6. HTTP headers

```
http example.org User-Agent:Bacon/1.0 'Cookie:valued-visitor=yes;foo=bar' \
    X-Foo:Bar Refer:http://httpie.org/
```

7. Authentication

```
//Basic auth
http -a username:password example.org
//Digest auth
http -A digest -a username:password example.org
```

8. HTTP redirects, --follow, -F

If you additionally wish to see the intermediary requests/responses, then use the --all option as well. To change the default limit of maximum 30 redirects, use the --max-redirects=<limit> option
```
http --follow --all --max-redirects=5 httpbin.org/redirect/3
```

9. Proxies

```
http --proxy=http:http://user:pass@10.10.1.10:3128 --proxy=https:https://10.10.1.10:1080 example.org

//SOCKS
http --proxy=http:socks5://user:pass@host:port --proxy=https:socks5://user:pass@host:port example.org
```

10. HTTPS

```
alias https='http --default-scheme=https'

//可以通过 --verify=no 忽略证书检查
http --verify=no https://example.org

//可以使用--ssl=<PROTOCOL>指定ssl版本
http --ssl=ssl3 https://vulnerable.example.org
```

11. Redirect output

```
http example.org/movie.mov > movie.mov
```

12. Download mode

```
http --download https://github.com/jkbrzt/httpie/archive/master.tar.gz
```

13. Sessions

```
http --session=user1 -a user1:password example.org X-Foo:Bar  create a new session
http --session=user1 example.org  refer to the session
```
