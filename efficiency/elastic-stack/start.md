# Elasticsearch的安装和启动

## 文件目录结构

| 目录 | 配置文件 | 描述 |
| :---: | :---: | :---: |
| bin | | 脚本文件、安装插件、运行统计数据等 |
| config | elasticsearch.yml | 集群配置文件，user、role based相关配置 |
| JDK | | Java运行环境
| data | path.data | 数据文件 |
| lib | | Java类库 |
| logs | path.log | 日志文件 |
| modules | | 包含所有ES模块 |
| plugins | | 包含所有已安装插件 |

## JVM 配置

+ 修改JVM - config/jvm.options
  + 7.1下载的默认设置是1GB
+ 配置的建议
  + Xmx和Xms设置成一样
  + Xmx不要超过机器内存的50%
  + 不要超过30GB
  + <https://www.elastic.co/blog/a-heap-of-trouble>

```
bin/elasticsearch -E node.name=node1 -E cluster.name=mycluster \
    -E path.data=node1_data -E http.port=9200
```

## 插件管理

```
# 查看已安装插件
bin/elasticsearch-plugin list

# 安装插件
bin/elasticsearch-plugin install analysis-icu
```