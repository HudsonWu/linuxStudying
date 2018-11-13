
## 加密
// -e加密, -aes-128-cbc指定使用加密算法, -iv指定偏移向量为16进制, -K指定16进制密钥, -in指定要加密的文件, -out指定密文输出文件
// 初始IV为16个字节的0x00, 密钥为 abcdefghijklmnop
> openssl enc -e -aes-128-cbc -iv 0000000000000000 -K 6162636465666768696a6b6c6d6e6f70 -in input -out output

//也可以直接用管道指向hexdump命令进行密文打印
> openssl enc -e -aes-128-cbc -iv 0000000000000000 -K 6162636465666768696a6b6c6d6e6f70 -in input | hexdump -C

## 解密
// -d解密
> openssl enc -d -aes-128-cbc -iv 0000000000000000 -K 6162636465666768696a6b6c6d6e6f70 -in input -out output

