# mcrypt, 加密和解密

## Installation

```
// ubuntu/debian
apt-get install mcrypt

// redhat/fedora/centos
yum install mcrypt
```

## Encryption

```
//不加参数, 交互式输入密码加密
mcrypt file1  //生成file1.nc加密文件

//使用-k参数, 分别指定密码加密文件
mcrypt file1 file2 -k abc123 ABC123  //file1.nc, file2.nc
```

## Decryption

```
mcrypt file1.nc  //解密出file1
mcrypt -k abc123 ABC123 -d file1.nc file2.nc  //file1, file2
md5sum file[1,2]  //验证文件完整性
```

## Encryption with compression

```
mcrypt -k abc123 -z file1  //先压缩再加密, file1.gz.nc
mcrypt -k abc123 -d file1.gz.nc  //file1.gz
gunzip -v file1.gz  //file1
md5sum file1
```

## Directory encryption

```
tar cz dir1/ | mcrypt -k abc123 > dir1.tar.gz.nc
mcrypt -k abc123 -d dir1.tar.gz.nc
tar xzf dir1.tar.gz
```

## Changing encryption algorithm

```
mcrypt --list-hash  //列出可以选择的加密算法
mcrypt -k abc123 -h whirlpool file1  //使用-h参数指定加密算法
```

## Configuring mcrypt

```
echo "key abc123" > ~/.mcryptrc  //配置默认密码
```
