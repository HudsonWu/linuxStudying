
## encoding

+ encoding变量
    + 使用于缓冲的文本（正在编辑的文本）、寄存器、vim脚本文件等
    + encoding变量的默认值与系统当前locale相同

+ fileencoding变量
    + 写入文件时采用的编码类型
    + vim打开文件时自动辨认其编码，为空则保存文件时采用encoding的编码

+ termencoding变量
    + 代表输出到客户终端采用的编码类型
    + 默认为空值，也就是输出到终端不进行编码转换

## 解决乱码问题 (.vimrc)
<pre>
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030
</pre>

## 编码转换
<pre>
// 也可使用iconv命令转码
:set fileencoding  //查看文件编码格式
:set fileformat  //查看文件格式签名编码
:set fileencoding=utf-8  //转换文件编码格式为utf-8格式
</pre>
