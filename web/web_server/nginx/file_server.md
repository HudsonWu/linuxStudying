# 搭建文件服务器

## /etc/nginx.conf文件

```
user root;

http {
  autoindex on; # 显示目录
  autoindex_exact_size on; # 显示文件大小
  autoindex_localtime on; # 显示文件时间
  charset utf-8,gbk;  # 解决乱码问题
}
```
