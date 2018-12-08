
## 脚本调试

1. 跟踪脚本的执行
```
bash -x example_script.sh
```
bash在运行前打印出了每一行命令

2. 在跟踪里输出行号 (设置环境变量)
```
export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '
```

3. 调试部分脚本
在你想要调试的脚本之前, 调用 set -x, 结束时调用 set +x <br/>
```sh
#!/bin/bash
echo "Hello $USER,"
set -x
echo "Today is $(date %Y-%M-%D)"
set +x
```

4. 专用调试器

> <http://bashdb.sourceforge.net/> <br/>


## 日志输出

跟踪日志有时候太多了, 而且输出的内容很难阅读 <br/>
一般来说, 很多时候只关心条件表达式, 变量值, 或是函数调用, 循环等 <br/>
以下代码实现了根据需要输出日志<br/>

使用log前, 写一个函数:
```sh
_log() {
    if [ "$_DEBUG" == "true" ]; then
        echo 1>&2 "$@"
    fi
}
```
在脚本中使用:
```sh
_log "Copying files..."
cp src/* dst/
```
可以看到, 上面那个`_log`函数, 需要检查一个`_DEBUG`变量, <br/>
只有这个变量为真, 才会真正输出日志<br/>
这样, 你就只需要控制这个开关, 而不需要删除你的debug信息<br/>
```
_DEBUG=true ./example_script.sh
```

## eval
<pre>
//eval首先会扫描命令行进行所有的置换, 然后再执行该命令
pipe="|"
eval ls $pipe wc -l
</pre>

## 输入输出

### stdin, 读取标准输入
```sh
read a b c
less <&0
cat -
cat "${1:-/dev/stdin}" > "${2:-/dev/stdout}"

while read line; do
    echo "reading: ${line}"
done < /dev/stdin
```

### 标准错误输出
```sh
result=$(ls -lh 2>&1 1>/dev/null)  //标准错误输出到变量
ls -lh 2>> result.log  //标准错误追加到文件
```

## 不同执行方式对文件权限的要求
+ bash xx.sh
    + 对脚本有r权限
    + 对脚本所在目录有rx权限
+ xx.sh
    + 对脚本有rx权限
    + 对脚本所在目录有rx权限

## 选项
```
选项启用和关闭的两种方式:
1. 使用-o加上选项的长名, 如 set -o noclobber, 开启; set +o noclobber, 关闭
直接使用set -o可以查看所有shell选项的状态
-o,  查看和启用shell选项
+o,  关闭shell选项
set -o pipefail, 包含管道命令的语句的返回值, 是最后一个返回非零命令的返回值
set -o posix, 启用posix标准检查
2. 使用选项的短名, 如set -f, 启用; set +f, 关闭
-x,  提供跟踪执行信息, 将执行的每条命令和结果依次打印出来
-v,  执行脚本的同时, 将执行过的脚本命令打印到标准错误输出
-n,  不执行脚本只检查语法错误
-u,  使用了没有定义的变量时报错
-e,  一旦出现了返回值非零, 整个脚本立即退出
-c "string", 从string中读取命令
```
