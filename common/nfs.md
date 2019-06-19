# nfs

## /etc/fstab

```
UUID=ed95cxxx / ext4 defaults 1 1
xxx.com:/ /mnt nfs4 vers=4.0,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,_netdev,noresvport 0 0
xxx.com:/ /mnt nfs rw 
```
