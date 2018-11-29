## 创建, 复制, 删除文件及文件夹

copy cd.dll %windir%\system32  //复制cd.dll文件到windows\system32中
del %windir%\system32\cd.dll  /删除cd.dll文件
del C:\DOWNLOAD\*.*  //删除download文件夹中的文件
rd Filemon  //删除Filemon文件夹 (只能删除空文件夹)
rd /s /q folder1  //删除folder1文件夹
(/s表示删除该文件夹及其下面的子目录和文件, /q表示不需要确认)
md "E:\MyDocuments\NewFolder1"  //新建文件夹

## 执行程序, 打开文件或目录
start C:\Test  //打开指定目录
start C:\WinWord.exe  //执行WinWord.exe程序
start d:\TheWorld\TheWorld.EXE "C:\MyDocuments\index.htm"  //用某个程序打开某个文件

## 拷贝文件夹 XCOPY

XCOPY命令可用于复制文件和目录, 包括子目录; 其功能多数是通过增加参数来实现的

XCOPY source [destination] 参数(如 /s /e) 
source 指定要复制的文件
destination 指定新文件的位置和/或名称
/A 只复制有存档属性集的文件, 但不改变属性
/M 只复制有存档属性集的文件, 并关闭存档属性
/D:m-d-y 复制在指定日期或指定日期以后改变的文件
如果没有提供日期, 只复制那些源时间 
比目标时间新的文件
/EXCLUDE:file1[+file2][+file3]... 
指定含有字符串的文件列表; 如果有任何 
字符串与要被复制的文件的绝对路径 
相符, 那个文件将不会得到复制
例如, 指定如 \obj\ 或 .obj 的字符串会排除 
目录 obj 下面的所有文件或带有 
.obj 扩展名的文件
/P 创建每个目标文件前提示
/S 复制目录和子目录, 除了空的
/E 复制目录和子目录, 包括空的
与 /S /E 相同; 可以用来修改 /T
/V 验证每个新文件
/W 提示您在复制前按键
/C 即使有错误, 也继续复制
/I 如果目标不存在, 又在复制一个以上的文件,  
则假定目标一定是一个目录
/Q 复制时不显示文件名
/F 复制时显示完整的源和目标文件名
/L 显示要复制的文件
/G 允许将没有经过加密的文件复制到 
不支持加密的目标
/H 也复制隐藏和系统文件
/R 改写只读文件
/T 创建目录结构, 但不复制文件; 不 
包括空目录或子目录; /T /E 包括 
空目录和子目录

/U 只复制已经存在于目标中的文件
/K 复制属性; 一般的 Xcopy 会重设只读属性
/N 用生成的短名复制
/O 复制文件所有权和 ACL 信息
/X 复制文件审核设置(隐含 /O)
/Y 禁止提示以确认改写一个 
现存目标文件
/-Y 导致提示以确认改写一个 
现存目标文件
/Z 用重新启动模式复制网络文件
