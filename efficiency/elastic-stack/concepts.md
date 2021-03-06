# Elasticsearch

## 文档 (Document)

+ Elasticsearch是面向文档的, 文档是所有可搜索数据的最小单位
+ 文档会被序列化成JSON格式, 保存在Elasticsearch中
+ 每个文档都有一个Unique ID
+ 一篇文档包含了一系列的字段, 类似数据库表中的一条记录

### 文档的元数据

```json
{
  "_index": "movies",
  "_type": "_doc",
  "_id": "1",
  "_score": 14.69302,
  "_source": {
    "year": 1995,
    "@version": "1",
    "genre": [
      "Adventure",
      "Animation",
      "Children",
      "Comedy",
      "Fantasy"    
    ],
    "id": 1,
    "title": "Toy Story"
}
}
```

元数据, 用于标注文档的相关信息
  + _index, 文档所属的索引名
  + _type, 文档所属的类型名
  + _id, 文档唯一Id
  + _source, 文档的原始Json数据
  + _all, 整合所有字段内容到该字段, 已被废除
  + _version, 文档的版本信息
  + _score, 相关性打分

## 索引

```json
{
  "movies": {
    "settings": {
      "index": {
        "creation_date": ""
      }
    }  
  }
}
```

索引是文档的容器, 是一类文档的结合
  + Index体现了逻辑空间的概念, 
    每个索引都有自己的mapping定义, 
    用于定义包含的文档的字段名和字段类型
  + Shard体现了物理空间的概念, 
    索引中的数据分散在shard上

索引的mapping和settings:
  + Mapping定义文档字段的类型
  + Setting定义不同的数据分布

```
# Type
## 6.0开始, Type已经被Deprecated
## 7.0之前, 一个Index可以设置多个Types
## 7.0开始, 一个索引只能创建一个Type, 即"_doc"
```

## 分片

+ 主分片(primary shard), 用于解决数据水平扩展的问题
  + 通过主分片, 可以将数据分布到集群内的所有节点之上
  + 一个分片是一个运行Lucene的实例
  + 主分片数在索引创建时指定, 后续不允许修改, 除非Reindex
+ 副本(replica shard), 用于解决数据高可用的问题
  + 分片是主分片的拷贝
  + 副本分片数可以动态调整
  + 增加副本数, 可以在一定程度上提高服务的可用性(读取的吞吐)

## 倒排索引

+ 单词词典(Term Dicrionary)
  + 记录所有文档的单词, 记录单词到倒排列表的关联关系
  + 单词词典一般比较大, 可以通过B+树或哈希拉链法实现, 以满足高性能的插入和查询
+ 倒排列表(Posting List)
  + 记录了单词对应的文档结合, 由倒排索引项组成
  + 倒排索引项(posting)
    + 文档ID
    + 词频TF, 单词在文档中出现的次数, 用于相关性评分
    + 位置(Position), 单词在文档中分词的位置, 用于语句搜索(phrase query)
    + 偏移(Offset), 记录单词的开始结束位置, 实现高亮显示
