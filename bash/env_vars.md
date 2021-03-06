## 显示
```
set, 显示当前shell的变量, 包括当前用户的变量
env, 显示当前用户的变量
export, 显示当前导出成用户变量的shell变量
```

## 设置
```
set, 当前shell进程的本地变量, 只在当前shell进程有效, 不会被子进程继承和传递
env, 仅为将要执行的子进程设置环境变量
export, 将一个shell本地变量提升为当前shell进程的环境变量, 
        从而被子进程自动继承, 但是export的变量无法改变父进程的环境变量
source, 运行脚本的时候, 不会启用一个新的shell进程, 而是在当前shell进程环境中运行
exec, 运行脚本或命令的时候, 不会启用一个新的shell进程, 
      并且exec后续的脚本内容不会得到执行, 即当前shell进程结束了
```

## 简单实例

1.sh:
```sh
#!/usr/bin/env bash
A=B
echo "PID for 1.sh before exec/source/fork: $$"
export A
echo "1.sh: \$A is $A"
case $1 in
    exec)
        echo "using exec ..."
        exec ./2.sh;;
    source)
        echo "using source ..."
        . ./2.sh;;
    *)
        echo "using fork by default ..."
        ./2.sh;;
esac
echo "PID for 1.sh after exec/source/fork: $$"
echo "1.sh: \$A is $A"
```

2.sh:
```sh
#!/usr/bin/env bash

echo "PID for 2.sh: $$"
echo "2.sh get \$A=$A from 1.sh"
A=C
export A
echo "2.sh: \$A is $A"
```
