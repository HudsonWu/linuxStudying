# nfs, Network File System

nfs, 网络文件系统, 让客户端通过网络访问不同主机磁盘里的数据, 
主要用在类Unix系统上, 实现文件共享的一种方法

## 服务端安装和配置

```
# install
yum install nfs-utils
systemctl start rpcbind
systemctl start nfs

# 开机启动
systemctl enable rpcbind
systemctl enable nfs

# 防火墙
firewall-cmd --zone=public --permanent --add-service=rpc-bind
firewalld-cmd --zone=public --permanent --add-service=mountd
firewalld-cmd --zone=public --permanent --add-service=nfs
firewalld-cmd --reload

# 创建共享目录
mkdir /data
chmod 755 /data

# /etc/exports
/data/ 192.168.0.0/24(rw,sync,no_root_squash,no_all_squash)

# 重启nfs
systemctl restart nfs

# 检查本地共享目录
showmount -e localhost
```

## 客户端安装和配置

```
# install
yum install nfs-utils
systemctl enable rpcbind
systemctl start rpcbind

# 查看服务端的共享目录
showmount -e 192.168.0.101

# 挂载
mkdir /data
mount -t nfs 192.168.0.101:/data /data

# 验证是否挂载成功
mount
```

### 客户端自动挂载 (/etc/fstab)

```
UUID=ed95cxxx / ext4 defaults 1 1
xxx.com:/ /mnt nfs4 vers=4.0,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev,noresvport 0 0
xxx.com:/ /data nfs rw
192.168.0.101:/data /data nfs defaults 0 0
```
