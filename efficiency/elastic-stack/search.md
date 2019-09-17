# Search API

+ URI Search, 在URL中使用查询参数
+ Request Body Search
  + 使用ElasticSearch提供的, 
  + 基于JSON格式的更加完备的Query Domain Specific Language (DSL)

## 指定查询的索引

```
语法                       范围
/_search              集群上所有的索引
/index1/_search            index1
/index1,index2/_search  index1和index2
/index*/_search       以index开头的索引
```

```
# URI查询
## 使用'q', 指定查询字符串
## query string syntax, KV键值对
curl -XGET "http://es:9200/my_index/_search?q=customer_first_name:Eddle"

# Request Body
curl -XGET "http://es:9200/my_index/_search" -H 'Content-Type: application/json' -d'
{
  "query":{
    "match_all": {}
  }
}'
```
