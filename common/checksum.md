# 使用checksum检查文件的完整性

checksum，校验和，就像文件的数字指纹，从一组数字数据中提取小数据，用于检测在数据传输或存储过程中可能出现的错误。

checksum由checksum算法生成，将一个文件作为输入并输出该文件的校验和值，最流行的校验和算法是：
  + Secure Hash Algorithms and variants (SHA-1, SHA-2等)
  + MD5 Algorithm

## 验证checksum命令

+ MD5校验和验证工具: md5sum
+ SHA-1校验和验证工具: sha1sum
+ SHA-256校验和验证工具: sha256sum

```
sha256sum ubuntu-mate-16.10-desktop-amd64.iso
```
