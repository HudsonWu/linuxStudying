# Trojan

## 在ubuntu安装Trojan

```sh
sudo apt-get install python-software-properties 
sudo add-apt-repository ppa:greaterfire/trojan
sudo apt update
sudo apt install trojan
```

## 创建CA证书

1. 安装所需工具
```
apt install gnutls-bin gnutls-doc
```

2. 创建CA模板ca.tmpl, 内容为
```
cn = "ff"
organization = "ff"
serial = 1
expiration_days = 3650
ca
signing_key
cert_signing_key
crl_signing_key
```
cn与organization可以随意填写, 但为了避免可能发生的问题, 服务器证书cn填vps的ip或域名

3. 生成CA密钥
```sh
certtool --generate-privkey --outfile ca-key.pem
```

4. 生成CA证书
```sh
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.tmpl --outfile ca-cert.pem
```

5. 创建服务器证书模板
创建文件server.tmpl, 内容为
```
cn = "xxx.xxx.xxx.xxx"
organization = "ff"
expiration_days = 3650
signing_key
encryption_key
tls_www_server
```

6. 生成服务器证书秘钥
```sh
certtool --generate-privkey --outfile server-key.pem
```

7. 生成服务器证书
```sh
certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template server.tmpl --outfile server-cert.pem
```

## 配置文件

服务端配置文件

```json
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "Password1",
        "Password2"
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/.../server-cert.pem",
        "key": "/.../server-key.pem",
        "key_password": "",
        "cipher": "ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS",
        "prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "reuse_session": true,
        "session_timeout": 300,
        "curves": "",
        "sigalgs": "",
        "dhparam": ""
    }
}
```

客户端配置文件

```json
{
    "run_type": "client",
    "local_addr": "127.0.0.1",
    "local_port": 1080,
    "remote_addr": "你的 VPS 的 IP",
    "remote_port": 443,
    "password": ["Password1"],
    "append_payload": true,
    "log_level": 1,
    "ssl": {
        "verify": true,
        "verify_hostname": true,
        "cert": "ca-cert.pem",
        "cipher": "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA:AES128-SHA:AES256-SHA:DES-CBC3-SHA",
        "sni": "你的 VPS 的 IP",
        "alpn": [
            "h2",
            "http/1.1"
        ],
        "reuse_session": true,
        "curves": "",
        "sigalgs": ""
    }
}
```

开启
```sh
trojan config_file 2> log_file //服务端开启
```

## References

+ <https://trojan-gfw.github.io/trojan/>
+ <https://github.com/trojan-gfw/trojan>

