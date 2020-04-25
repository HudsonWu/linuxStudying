# 变量

## 变量定义

```
# 使用-v选项
awk -v foo=1 -v bar=2 ...

# 和输入文件名一起
awk -f program.awk file1 count=1 file2

# 在BEGIN内
awk 'BEGIN { RS = "u" }
      { print $0 }' data
```
