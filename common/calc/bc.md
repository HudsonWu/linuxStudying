# bc
bc是一种任意精度计算语言，它提供了一些语法结构，比如条件判断、循环等

## 选项
-i,  强制交互模式
-l,  使用bc的内置库, bc里有一些数学库, 对三角计算等非常实用
-q,  进入bc交互模式时不再输出版本等多于信息

## 特殊变量
ibase, obase用于进制转换, ibase是输入的进制, obase是输出的进制, 默认是十进制
scale 小数保留位数, 默认保留0位

## 使用

### 通过管道使用bc来计算

> echo "3 * 4" | bc
> echo "scale=7;355/113" | bc

### 进制转换

> echo "ibase=16;FFFF" | bc  //16进制转10进制
> echo "obase=16;1000" | bc  //10进制转16进制
> echo "obase=2;ibase=10;100" | bc  //十进制转二进制

### 将多个表达式写在一个文件中一起计算
> cat test.bc
123*321
123/321
scale=4;123/321
> bc test.bc
> cat test.bc | bc

### 使用bc命令的脚本片段

//计算两个数的和
> calc_sum()
> {
> bc -q <<EOF
> $1+$2
> EOF
> }
