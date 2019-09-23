# 解决问题

## 磁盘占用率高

```
# 查询集群健康度
GET _cluster/health

# 查询所有索引信息
GET _cat/indices

# 删除指定索引
DELETE indexname1

# 设置监控索引(.monitoring-es-*)保留天数
PUT _cluster/settings
{"persistent": {"xpack.monitoring.history.duration": "1d"}}

# 设置需要采集监控的索引
# 禁掉的索引监控信息将不会在Kibana的Monitoring模块中看到, 
# 比如在索引列表及索引监控信息页面, 都看不到禁掉的索引信息
# 就会出现_cat/indices获取的索引列表, 跟在Kibana的Monitoring模块中
# 看到的索引列表不同的情况
PUT _cluster/settings
{"persistent": {"xpack.monitoring.collection.indices": "*,-.*"}}
```

