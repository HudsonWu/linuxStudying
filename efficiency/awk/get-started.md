# 快速开始

```
# 打印大于80个字符的行
awk 'length($0) > 80' data

# 打印最长输入行的长度
awk '{ if (length($0) > max) max = length($0) }
     END { print max }' data

# 打印最长输入行的长度
# expand, 将tab转换成空格
expand data | awk '{ if (x < length($0)) x = length($0) }
                    END { print "maximum line length is " x }'

# 打印至少有一个字段的行, 可以用来删除空行
awk 'NF > 0' data

# 打印0到100之间的随机7个数字
awk 'BEGIN { for (i=1; i<=7; i++)
                 print int(101 * rand()) }'

# 计算当前目录所有文件的总大小(bytes)
ls -l | awk '{ x+= $5 }
    END { print "total bytes: " x }'

# 计算当前目录所有文件的总大小(kilobytes)
ls -l | awk '{ x+= $5 }
    END { print "total K-bytes: ", x / 1024 }'

# 打印排序后的用户名列表
awk -F: '{ print $1 }' /etc/passwd | sort

# 打印总行数
awk 'END { print NR }' data

# 打印偶数行
awk 'NR % 2 == 0' data

# 根据最后修改时间统计文件
ls -l | awk '$6 == "Nov" { sum += $5 }
             END { print sum }'

# 统计连接数
ss -n | awk '/^tcp/ { ++S[$NF] } END { for (a in S) print a, S[a] }'
```

