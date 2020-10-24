# 一些使用技巧

```
# 处理文件以及标准输入
some_command | awk -f myprog.awk file1 - file2

# 打印指定字段
awk '{for(i=4;i<=NF;++i){printf("%s ", $i)}; printf("\n")}'
```
