## 安装

> yum -y install http://dl.fedoraproject.org/pub/epel/6/x86_64/Packages/g/gridsite-clients-2.2.6-2.el6.x86_64.rpm \
> http://dl.fedoraproject.org/pub/epel/6/x86_64/Packages/g/gridsite-libs-2.2.6-2.el6.x86_64.rpm \
> http://dl.fedoraproject.org/pub/epel/6/x86_64/Packages/c/canl-c-2.1.8-1.el6.x86_64.rpm

## 使用

查看归档日志
> urlencode -d decode $(zcat access.log.2018_09_01_22.log.gz |awk '{print $7}' |sort |uniq -c |sort -rn |head )

查看实时日志
> tailf access.log |awk '{print $7}'|xargs urlencode -d decode
