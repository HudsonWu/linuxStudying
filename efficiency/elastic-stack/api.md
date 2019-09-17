# restapi

## indices

```
# 查看索引相关信息
GET index_sample

# 查看索引的文档总数
GET index_sample/_count

# 查看前10条文档
POST index_sample/_search
{

}

# _cat indices API
## 查看indices
GET /_cat/indices/kibana*?v&s=index
## 查看状态为绿的索引
GET /_cat/indices?v&health=green
## 按照文档个数排序
GET /_cat/indices?v&s=docs.count:desc
## 查看具体的字段
GET /_cat/indices/kibana*?pri&v&h=health,index,pri,rep,docs,count,mt
```

## 集群

```
# 查看集群健康状况
GET _cluster/health
# 查看节点信息
GET _cat/nodes
# 查看分片信息
GET _cat/shards
```
