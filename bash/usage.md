
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
<pre>
bash -x xx.sh  执行该脚本并显示脚本执行的过程
bash -n xx.sh  不执行脚本只检查语法错误
</pre>
