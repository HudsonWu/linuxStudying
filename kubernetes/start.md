## 安装和配置

安装etcd和kubernetes软件 (会自动安装docker)
> yum install -y etcd kubernetes

配置文件修改
1. docker配置文件, /etc/sysconfig/docker
> OPTIONS='--selinux-enabled=false --insecure-registry gcr.io'
2. apiserver配置文件, /etc/kubernetes/apiserver
把--admission_control参数中的ServiceAccount删除

## 按顺序启动所有服务
<pre>
systemctl start etcd
systemctl start docker
systemctl start kube-apiserver
systemctl start kube-controller-manager
systemctl start kube-scheduler
systemctl start kubelet
systemctl start kube-proxy
</pre>

