# mysql

## 调整MySQL参数提高写入速度

+ <https://blog.csdn.net/u014595019/article/details/50526539>

```
# 原值
innodb_buffer_pool_size = 1610612736
innodb_log_file_size = 1048576000
innodb_log_buffer_size = 8388608
innodb_flush_log_at_trx_commit = 1

# 更改为
innodb_buffer_pool_size = 3006477107
innodb_log_file_size = 536870912
innodb_log_buffer_size = 8388608
innodb_flush_log_at_trx_commit = 2
```
