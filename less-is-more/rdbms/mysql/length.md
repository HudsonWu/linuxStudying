# 数据容量

## information_schema.tables

information_schema.tables 提供的是根据采样获取的表的部分统计信息, 因此通过下面的查询获取的表、库数据尺寸和实际数据文件占用尺寸间会有出入（通常要小于实际数据文件占用空间）

```sql
select table_name, table_schema, 
       concat(round((data_length + index_length) / 1024 / 1024, 2), 'MB')
from
    information_schema.tables;
```

在 delete 操作删除数据后, 需要通过 optimize table tab_name; 操作来回收空间
