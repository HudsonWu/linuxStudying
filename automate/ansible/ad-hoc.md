# ad-hoc

```
# 查看一个集群中所有节点的负载情况
ansible host1 -m raw -a 'uptime'

# 拷贝文件
ansible host1 -m synchronize -a 'src=zbs_rest dest=/usr/lib/python2.7/site-packages/'

# 移除cron job
ansible host1 -m cron -a "name='restart agent' state=absent"
```
