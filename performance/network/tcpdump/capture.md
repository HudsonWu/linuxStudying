# 抓包技巧

```
# 可以使用ping工具来分隔不同步骤，增加可视化
## windows, -n请求数，-l包大小
ping x.x.x.x -n 1 -l 1
步骤一
ping x.x.x.x -n 1 -l 2
步骤二
## linux, -c请求数, -s包大小
ping x.x.x.x -c 1 -s 1
步骤一
ping x.x.x.x -c 1 -s 2
步骤二
```
