# 默认协议为http://, 如果主机是localhost, 可以简写
> http :3000  // http://localhost:3000
> http :/foo  // http://localhost/foo

# 使用param==value语法向url添加参数
> http www.google.com search=='HTTPie logo' tbm==isch

# param=value格式的参数全部会转换成json格式传输, 且value全是字符串
> http PUT example.org name=John email=john@example.org

# 非字符串使用 := =@ :=@
> http PUT api.example.com/person/1 \
    name=John \
    age:=29 married:=false hobbies:='["http", "pies"]' \ # Raw JSON
    description=@about-john.txt \ # Embed text file
    bookmarks:=@bookmarks.json  # Embed JSON file

# Forms, --form, -f option which ensures that data fields are serialized as, 
# and Content-Type is set to, application/x-www-form-urlencoded; charset=utf-8
> http --form POST api.example.org/person/1 name='John Smith' \
    email=john@example.org cv=@~/Documents/cv.txt

# HTTP headers
> http example.org User-Agent:Bacon/1.0 'Cookie:valued-visitor=yes;foo=bar' \
    X-Foo:Bar Refer:http://httpie.org/

# Authentication
# Basic auth
> http -a username:password example.org
# Digest auth
> http -A digest -a username:password example.org

# HTTP redirects, --follow, -F
# If you additionally wish to see the intermediary requests/responses, then use the --all option as well
# To change the default limit of maximum 30 redirects, use the --max-redirects=<limit> option
> http --follow --all --max-redirects=5 httpbin.org/redirect/3

# Proxies
> http --proxy=http:http://user:pass@10.10.1.10:3128 --proxy=https:https://10.10.1.10:1080 example.org

# SOCKS
> http --proxy=http:socks5://user:pass@host:port --proxy=https:socks5://user:pass@host:port example.org

# HTTPS
> alias https='http --default-scheme=https'
# 可以通过 --verify=no 忽略证书检查
> http --verify=no https://example.org
# 可以使用--ssl=<PROTOCOL>指定ssl版本
> http --ssl=ssl3 https://vulnerable.example.org

# Redirect output
> http example.org/movie.mov > movie.mov

# Download mode
> http --download https://github.com/jkbrzt/httpie/archive/master.tar.gz

# Sessions
> http --session=user1 -a user1:password example.org X-Foo:Bar  # create a new session
> http --session=user1 example.org  # refer to the session
