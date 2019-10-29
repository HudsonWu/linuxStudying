# dotnet core 调试生成的dump文件

## 待调试的应用容器

```
# 启动容器
docker run -d -p 80:80 --name dumptest --ulimit core=-1 \
       --security-opt seccomp=unconfined --privileged=true dumptest:v1

# --ulimit core=-1, 不限制coredump大小
# --security-opt seccomp=unconfined, 允许容器执行全部系统调用
# --privileged=true, 允许createdump访问其他进程

# 在容器内部执行命令创建dump文件
## 容器进程ID为1, dump文件创建为/tmp/coredump.1
/usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.7/createdump 1
```

## 分析应用容器生成的dump文件

```
# 启动lldb
lldb dotnet -c /dump/coredump.1 -o \
     "plugin load /usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.7/libsosplugin.so"

# 如果sos加载失败, 启动后执行命令
plugin load /usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.7/libsosplugin.so
# 如果runtime加载失败, 启动后执行命令
setclrpath /usr/share/dotnet/shared/Microsoft.NETCore.App/2.2.7

# 查看可以使用的命令
soshelp

# 查看堆上的对象类型分配情况
## 大于1024byte
dumpheap -stat -min 1024

# 查看指定类型对象情况
dumpheap -mt 00007f1529eb5690 -min 1024

# 查看指定对象情况
dumpobj 00007f13041f04b8
```
