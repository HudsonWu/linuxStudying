# root和alias指令的用法和区别

## root和alias指令的区别

### 作用域不同

nginx指定文件路径有另种方式：root和alias，指令的用法和作用域如下：
  + root
    + 语法：root path
    + 默认值：root html
    + 配置段：http, server, location, if
  + alias
    + 语法：alias path
    + 配置段：location

### 对服务器文件的不同映射方式

alias是一个目录别名的定义，root则是最上层目录的定义。

root和alias主要区别在于nginx如何解释location后面的uri，这会使两者分别以不同的方式将请求映射到服务器文件上：
  + root的处理结果是：root路径+location路径
  + alias的处理结果是：使用alias路径替换location路径

### 是否必须要用'/'结束

还有一个重要的区别是alias后面必须要用'/'结束，否则会找不到文件，而root则可有可无

## 实例

root实例：
```
location ^~ /t/ {
  root /www/root/html/;
}
```
如果一个请求的URI是/t/a.html，web服务器将会返回服务器上的/www/root/html/t/a.html文件

alias实例：
```
location ^~ /t/ {
  alias /www/root/html/new_t/;
}
```
如果一个请求的URI是/t/a.html，web服务器会返回服务器上的/www/root/html/new_t/a.html文件
