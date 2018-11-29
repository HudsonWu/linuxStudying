## find 排除某目录或文件
1. 查找cache目录下不是html的文件
find ./cache ! -name "*.html" -type f
2. 列出当前目录下的目录名, 排除includes目录, 后面的-print不能少
find . -path './includes' -prune -o -type d -maxdepth 1 -print
3. 排除多个目录
find /usr/sam \( -path /usr/sam/dir1 -o path /usr/sam/file1 \) -prune -o -print
(-path "/usr/sam" -prune -o -print 是 -path "/usr/sam" -a -prune -o -print 的简写表达式按顺序求值, 
-a 和 -o 都是短路求值, 与 shell 的 && 和 || 类似
如果 -path "/usr/sam" 为真, 则求值 -prune , -prune 返回真, 与逻辑表达式为真, 否则不求值 -prune, 与逻辑表达式为假
如果 -path "/usr/sam" -a -prune 为假, 则求值 -print , -print返回真, 或逻辑表达式为真；否则不求值 -print, 或逻辑表达式为真)

## find 递归/不递归查找子目录

1. 递归查找
find . -name "*.txt"
2. 不递归查找
find . -name "*.txt" -maxdepth 1

## find命令之exec

1. -exec 参数后面跟的是command命令, 以 ; 为结束标志, 所以分号是不可缺少的, 
考虑到各个系统中分号会有不同的意义, 所以前面加反斜杠

2. {} 花括号代表前面find查找出来的文件名 

### 实例

1. 先查看相应的文件, 然后删除
find . -type f -mtime +14 -exec ls -l {} \;
find . -type f -mtime +14 -exec rm {} \;

2. 删除前给出提示
find -name "*.log" -mtime +5 -ok rm {} \;

3. 使用grep命令
find /etc -name "passwd*" -exec grep "root" {} \;

4. 移动文件位置
find . -name "*.log" -exec mv {} .. \;

5. 查找所有空文件
find ~ -empty
