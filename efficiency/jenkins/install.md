# jenkins

## 安装和启动

### 安装

```
# 安装java
yum install -y java-1.8.0-openjdk

# 导入yum源
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# 安装jenkins
yum install -y jenkins

# jenkins启动脚本: /etc/init.d/jenkins
# jenkins配置文件: /etc/sysconfig/jenkins

# 启动jenkins
systemctl start jenkins

# 将jenkins设置为自启动
/sbin/chkconfig jenkins on
```

