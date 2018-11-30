## apt-key
apt-key命令用于管理Debian Linux系统中的软件包密钥<br/>
每个发布的deb包, 都是通过密钥认证的, apt-key用来管理密钥<br/>

<pre>
//语法: apt-keky (参数)
//APT密钥操作指令

apt-key list  //列出已保存在系统中的key
apt-key list | grep "expired:"  # to quickly find the expired keys

apt-key add keyname  //把下载的key添加到trusted数据库中

apt-key del keyname  //从本地trusted数据库删除key

apt-key update  //更新本地trusted数据库, 删除过期没用的key

//从指定服务器更新key
apt-key adv --keyserver keys.gnupg.net --recv-keys [key] 

//verify that you now have the key with the fingerprint
apt-key fingerprint [key]
</pre>
