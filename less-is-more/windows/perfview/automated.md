# 使用perfview命令自动监控CPU

+ <https://docs.microsoft.com/zh-cn/archive/blogs/highcpucapture/perfview-command-for-capturing-automated-high-cpu-dumps>

```
# 只有一个w3wp.exe进程的情况
Perfview /NoGui collect "/StopOnPerfCounter=Process:% Processor Time:w3wp>25" -ThreadTime -CircularMB:1000 -CollectMultiple:5 –accepteula 

# 有多个w3wp.exe进程
## 通过性能监视器找到指定进程的实例名称，例如w3wp#2
Perfview /NoGui collect "/StopOnPerfCounter=Process:% Processor Time:w3wp#2>75" -ThreadTime -CircularMB:1000 -CollectMultiple:5 –accepteula
```
