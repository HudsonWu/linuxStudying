# 文档的CRUD

**Type名, 约定都用_doc**

## Create

```
# 指定文档ID, 如果id存在, 报错
PUT my_index/_create/1
{"user":"mike","comment":"You know, for search"}

# 指定文档ID, 如果id存在, 报错
PUT my_index/_doc/1?op_type=create
{"user":"mike","comment":"You know, for search"}

# 自动生成文档ID
POST my_index/_doc
{"user":"mike","comment":"You know, for search"}
```

## Read

```
# 获取文档
GET my_index/_doc/1
```

## Update

更新文档, 文档必须存在, 更新只会对相应字段做增量修改

```
POST my_index/_update/1
{ "doc":{"user":"mike","comment":"You know, Elasticsearch"} }
```

## Delete

```
# 删除文档
DELETE my_index/_doc/1
```

## Index

Index和Create不一样的地方:
  + 如果文档不存在, 就索引新文档;
  + 否则现有文档会被删除, 新的文档被索引, 版本信息+1

```
PUT my_index/_doc/1
{"user":"mike","comment":"You know, index"}
```
