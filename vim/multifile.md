# vim打开或编辑多个文件

## 在同一窗口中打开多个文件

vi file1 file2 file3
:n  //切换到下一个文件
:N  //切换到上一个文件
:xn  //切换到向下的第x个文档
:ls  //展示全部打开的文档


## 在不同窗口中打开多个文件

1. 已经打开了一个文件
:sp file2  //水平分割
:vsp file2  //纵向分割
:new file2

2. 用分割屏幕窗口方式同时打开多个文件
vi -o file1 file2 file3  //水平分屏
vi -O file1 file2 file3  //纵向分屏
:qa  //关闭所有


