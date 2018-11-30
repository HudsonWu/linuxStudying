## GnuPG
是目前最流行、最好用的加密工具之一<br/>

### 密钥管理
<pre>
1. 生成密钥
gpg --gen-key
2. 生成“撤销证书“
gpg --gen-revoke [用户ID]
"用户ID”部分可以填入邮件地址或者Hash字符串
3. 列出密钥
gpg --list-keys
4. 删除密钥
gpg --delete-key [用户ID]
5. 输出密钥
公钥文件（.gnupg/pubring.gpg）以二进制形式存储，armor参数可以将其转换成ASCII码显示
gpg --armor  --output public-key.txt --export [用户ID]
“用户ID”指定哪个用户的公钥，output参数指定输出文件名
gpg --armor --output private-key.txt --export-secret-keys
export-secret-keys参数可以转换私钥
6. 上传公钥
公钥服务器是网络上专门存储用户公钥的服务器，send-keys参数可以将公钥上传到服务器
gpg --send-keys [用户ID] --keyserver hkp://subkeys.pgp.net
使用上面的命令，你的公钥就被传到了服务器subkeys.pgp.net，然后通过交换机制，所有的公钥服务器最终都会包含你的公钥
由于公钥服务器没有检查机制，任何人都可以用你的名义上传公钥，所以没有办法保证服务器上公钥的可靠性，通常，你可以在网站上公布一个公钥指纹，让其他人核对下载到的公钥是否为真，fingerprint参数生成公钥指纹：
gpg --fingerprint [用户ID]
7. 输入密钥
gpg --import [密钥文件]
为了获得他人的公钥，可以让对方直接发给你，或者到公钥服务器上寻找
gpg --keyserver hkp://subkeys.pgp.net --search-keys [用户ID]
gpg --keyserver hkp://subkeys.pgp.net --recv [用户ID]
gpg --recv-keys [用户ID]
</pre>

### 加密和解密
<pre>
1. 加密
gpg --recipient [用户ID] --output demo.en.txt --encrypt demo.txt
recipient参数指定接收者的公钥，output参数制定加密后的文件名，encrypt参数指定源文件
2. 解密
gpg --decrypt demo.en.txt --output demo.de.txt
decrypt参数指定需要解密的文件，output参数指定解密后生成的文件
GPG允许省略decrypt参数
gpg demo.en.txt
运行上面的命令后，解密后的文件内容直接显示在标准输出
</pre>

### 签名
<pre>
1. 对文件签名
有时，我们不需要加密文件，只需要对文件签名，表示这个文件确实是我本人发出的
gpg --sign demo.txt
运行上面的命令后，当前目录下生成demo.txt.gpg文件，这就是签名后的文件，默认采用二进制存储，如果想生成ASCII码的签名文件，可以使用clearsign参数
gpg --clearsign demo.txt
运行上面的命令后，当前目录下生成demo.txt.asc文件，后缀名asc表示该文件是ASCII码形式的
如果想生成单独的签名文件，与文件内容分开存放，可以使用detach-sign参数
gpg --detach-sign demo.txt
运行上面的命令后，当前目录下生成一个单独的签名文件demo.txt.sig，该文件是二进制形式的，如果想要采用ASCII码形式，要加上armor参数
gpg --armor --detach-sign demo.txt
2. 签名+加密
gpg --local-user [发信者ID] --recipient [接收者ID] --armor --sign --encrypt demo.txt
local-user参数指定用发信者的私钥签名，recipient参数指定用接收者的公钥加密，armor参数表示采用ASCII码形式显示，sign参数表示需要签名，encrypt参数制定源文件
3. 验证签名
gpg --verify demo.txt.asc demo.txt

gpg --keyserver subkeys.pgp.net --recv 4F6C1E86
gpg --export --armor 4F6C1E86 | sudo apt-key add -
(pgpkeys.mit.edu  keys.gnupg.net  ubuntu PPA: keyserver.ubuntu.com)

wget -qO - https://mirrors.ustc.edu.cn/kali/dists/kali-rolling/Release.gpg | sudo apt-key add -
</pre>

### 常用命令
```sh
gpg --full-generate-key  //生成GPG密钥对
gpg --list-secret-keys --keyid-format LONG  //密钥列表
gpg --armor --export 3AA5C34371567BD2  //使用ASCII armor格式打印密钥ID
//Copy your GPG key, beginning with -----BEGIN PGP PUBLIC KEY BLOCK----- and ending with -----END PGP PUBLIC KEY BLOCK-----
```
