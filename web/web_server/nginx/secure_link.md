# `secure_link`模块

## `secure_link_md5`

```
# 生成md5
echo -n 'timestamp/linkclient_ip secret' | openssl md5 -binary | openssl base64 | tr +/ - | tr -d =

# 原请求
/link

# 安全请求
/link?md5=6bAoyxxDaQI9SeZrnpDv7A&expires=1586595553

# nginx配置
secure_link $arg_md5,$arg_expires;
secure_link_md5 "$secure_link_expires$uri$remote_addr secret";
if ($secure_link = "") {
  return 403;
}
if ($secure_link = "0") {
  return 410;
}
return 200 '$secure_link:$secure_link_expires\n';
```

## `secure_link_secret`

```
# 生成md5
echo -n 'linksecret' | openssl md5 -hex

# 原请求
/link

# 安全请求
/prefix/md5/link

# nginx配置
location /prefix/ {
  secure_link_secret secret;
  if ($secure_link = "") {
    return 403;
  }
}
rewrite ^ /secure/$secure_link;
```
