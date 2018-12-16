# nginx 配置url重写

url重写是指通过配置conf文件, 以让网站的url达到某种状态时定向/跳转到某个规则, 比如常见的伪静态, 301重定向, 浏览器定向等

## rewrite

### 语法

```
server {
  rewrite 规则 定向路径 重写类型;
}
```

```
规则: 可以是字符串或者正则, 来表示想匹配的目标url
定向路径: 表示匹配到规则后要定向的路径, 如果规则里有正则, 则可以使用$index来表示正则里的捕获分组
重写类型: 
  last : 相当于Apache里的L标记, 表示完成rewrite, 浏览器地址栏URL地址不变
  break: 本条规则匹配完成后, 终止匹配, 不再匹配后面的规则, 浏览器地址栏URL地址不变
  redirect: 返回302临时重定向, 浏览器地址会显示跳转后的URL地址
  permanent: 返回301永久重定向, 浏览器地址栏会显示跳转后的URL地址
```

```
server {

    # 访问 /last.html 的时候, 页面内容重写到 /index.html 中
    rewrite /last.html /index.html last;

    # 访问 /break.html 的时候, 页面内容重写到 /index.html 中, 并停止后续的匹配
    rewrite /break.html /index.html break;

    # 访问 /redirect.html 的时候, 页面直接302定向到 /index.html中
    rewrite /redirect.html /index.html redirect;

    # 访问 /permanent.html 的时候, 页面直接301定向到 /index.html中
    rewrite /permanent.html /index.html permanent;

    # 把 /html/*.html => /post/*.html , 301定向
    rewrite ^/html/(.+?).html$ /post/$1.html permanent;

    # 把 /search/key => /search.html?keyword=key
    rewrite ^/search\/([^\/]+?)(\/|$) /search.html?keyword=$1 permanent;
}
```
