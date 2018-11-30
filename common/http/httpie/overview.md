https://github.com/jakubroztocil/httpie

# 安装
debian系列:
> apt-get install httpie
rhel系列:
> yum install httpie
python方式:
> pip install --upgrade httpie
> pip install --upgrade https://github.com/jkbrzt/httpie/tarball/master


# 使用

## 如果不带METHOD参数, 默认为GET(没有附带请求参数)或POST(附带请求参数, 默认以json格式传输)
> http example.org
> http example.org hello=world

## GET方法
+ 定制头部
> http tonydeng.github.io/blog/2015/07/10/httpie-howto/ User-Agent:Xmodlo/1.0 Refer:http://tonydeng.github.io

+ 下载文件
> http tonydeng.github.io/blog/2015/07/10/httpie-howto/ > httpie-howto.html
或者
> http --download tonydeng.github.io/blog/2015/07/10/httpie-howto/

## 其他HTTP方法
+ PUT
> http PUT tonydeng.github.io name='Tony Deng' email='tonydeng@email.com'

+ POST
> http -f POST tonydeng.github.io name='Tony Deng' email='tonydeng@email.com'
-f选项使http命令序列化数据字段, 并将Content-Type设置为application/x-www-form-urlencoded;charset=utf-8

+ HEAD
> http HEAD tonydeng.github.io

## JSON支持
HTTPie内置JSON支持, 事实上HTTPie默认使用的Content-Type就是application/json

## 输入重定向
> http POST tonydeng.github.io < my_info.json
或者
> echo '{"name": "Tony Deng", "email: "tonydeng@email.com"} ' | http POST tonydeng.github.io