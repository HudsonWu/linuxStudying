## httpie

> https://github.com/jakubroztocil/httpie <br/>

<pre>
安装:

apt-get install httpie
yum install httpie
//python方式
pip install --upgrade httpie
pip install --upgrade https://github.com/jkbrzt/httpie/tarball/master
</pre>

<pre>
1. 默认请求方法
//如果不带METHOD参数, 且没有附带请求参数时默认使用GET方法请求
http example.org
//附带请求参数时, 默认以json格式传输, 默认使用GET方法请求
http example.org hello=world 

2. GET方法
//定制头部
http tonydeng.github.io/blog/httpie-howto/ User-Agent:Xmodlo/1.0 Refer:http://tonydeng.github.io
//下载文件
http tonydeng.github.io/blog/httpie-howto/ httpie-howto.html
//或者
http --download tonydeng.github.io/blog/httpie-howto/

3. PUT方法
http PUT tonydeng.github.io name='Tony Deng' email='tonydeng@email.com'

4. POST方法
http -f POST tonydeng.github.io name='Tony Deng' email='tonydeng@email.com'
//-f选项使http命令序列化数据字段, 并将Content-Type设置为application/x-www-form-urlencoded;charset=utf-8

5. HEAD
http HEAD tonydeng.github.io

6. JSON支持
HTTPie内置JSON支持, 事实上HTTPie默认使用的Content-Type就是application/json

7. 输入重定向
http POST tonydeng.github.io < my_info.json
//或者
echo '{"name": "Tony Deng", "email: "tonydeng@email.com"} ' | http POST tonydeng.github.io
</pre>
