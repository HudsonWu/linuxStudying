## openssl

### 加密
<pre>
//-e, 加密  -aes-128-cbc, 指定使用的加密算法
//-iv, 指定偏移向量为16进制  -K, 指定16进制密钥
//-in, 指定要加密的文件  -out, 指定密文输出文件
// 初始IV为16个字节的0x00, 密钥为 abcdefghijklmnop
openssl enc -e -aes-128-cbc -iv 0000000000000000 -K 6162636465666768696a6b6c6d6e6f70 -in input -out output
//也可以直接用管道指向hexdump命令进行密文打印
openssl enc -e -aes-128-cbc -iv 0000000000000000 -K 6162636465666768696a6b6c6d6e6f70 -in input | hexdump -C
</pre>

### 解密
<pre>
// -d解密
openssl enc -d -aes-128-cbc -iv 0000000000000000 -K 6162636465666768696a6b6c6d6e6f70 -in input -out output
</pre>
