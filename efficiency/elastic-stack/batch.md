# 批量操作

## Bulk API

+ 支持在一次API调用中, 对不同的索引进行操作
+ 支持四种类型的操作
  + Index
  + Create
  + Update
  + Delete
+ 可以在URI中指定Index, 也可以在请求的payload中进行
+ 操作中单条操作失败, 不会影响其他操作
+ 返回结果包括了每一条操作执行的结果

```
POST _bulk
{"index":{"_index":"test","_id":"1"}}
{"field1":"value1")
{"delete":{"_index":"test", "_id":"2"}}
{"create":{"_index":"test2","_id":"3"}}
{"field1":"value3"}
{"update":{"_id":"1","_index":"test"}}
{"doc":{"field2":"value2"}}
```

## mget, 批量读取

批量操作, 可以减少网络连接所产生的开销, 提高性能

```
GET _mget
{
  "doc":[
    {
      "_index":"user",
      "_id":1
    },
    {
      "_index":"comment",
      "_id":1
    }
  ]
}
```

## msearch, 批量查询

```
POST my_index/_msearch
{}
{"query":{"match_all":{}},"from":0,"size":10}
{}
{"query":{"match_all":{}}}
{"index":"twitter2"}
{"query":{"match_all":{}}}
```
