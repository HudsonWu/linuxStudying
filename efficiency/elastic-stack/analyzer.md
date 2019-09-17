# Analysis 与 Analyzer

+ Analysis, 文本分析, 也叫分词
  + 把全文本转换成一系列单词(term/token)的过程
  + Analysis是通过Analyzer来实现的
    + 可使用es内置的分析器或者按需定制化分析器
+ 除了在数据写入时转换词条, 匹配Query语句时也需要用相同的分析器对查询语句进行分析

## Analyzer

分词器是专门处理分词的组件, 由三部分组成
  + Character Filters, 针对原始文本处理, 例如去除html
  + Tokenizer, 按照规则切分为单词
  + Token Filter, 将切分的单词进行加工, 小写, 删除stopwords, 增加同义词

Elasticsearch的内置分词器
```
Standard Analyzer, 默认分词器, 按词切分, 小写处理
Simple Analyzer, 按照非字母切分(符号被过滤), 小写处理
Stop Analyzer, 小写处理, 停用词过滤(the, a, is)
Whitespace Analyzer, 按照空格切分, 不转小写
Keyword Analyzer, 不分词, 直接将输入当作输出
Patter Analyzer, 正则表达式, 默认\W+ (非字符分隔)
Language, 提供了30多种常见语言的分词器
Customer analyzer, 自定义分词器
```

## _analyzer API

```
# 直接指定Analyzer进行测试
GET /_analyze
{
  ”analyzer": "standard",
  "text": "Mastering Elasticsearch, elasticsearch in Action"
}

# 指定索引的字段进行测试
POST books/_analyze
{
  "field": "title",
  "text": "Mastering Elasticsearch"
}

# 自定义分词器进行测试
POST /_analyze
{
  "tokenizer": "standard",
  "filter": ["lowercase"]
  "text": "Mastering Elasticsearch"
}
```
