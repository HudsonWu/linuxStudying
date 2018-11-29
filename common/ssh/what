## SSH协议
+ 传输层协议(The Transport Layer Protocol)
提供服务器认证, 数据机密性, 信息完整性等支持
+ 用户认证协议(The User Authentication Protocol)
为服务器提供客户端的身份鉴别
+ 连接协议(The Connection Protocol)
将加密的信息隧道划分成若干逻辑通道, 提供给更高层应用协议使用

## OpenSSH提供了以下几个工具
1. ssh    实现ssh协议, 用以建立安全连接
2. scp, sftp    利用ssh协议远程传输文件
3. sshd    ssh服务器守护进程
4. ssh-keygen    用以生成RSA或DSA密钥对
5. ssh-agent, ssh-add    管理密钥的工具
6. ssh-keyscan    扫描网络中的主机, 记录找到的公钥

## ssh-keygen
> ssh-keygen  //等价于ssh-keygen -t rsa
(ssh-keygen -t rsa -C "youremail@email.com" -f ~/.ssh/id2_rsa)
> scp-copy-id user@host    将公钥传送到远程主机host上
> touch ~/.ssh/config  //config文件管理多个密钥
> chmod 600 ~/.ssh/config

## git中ssh
1. ssh -vT git@github.com
2. ssh -i ~/.ssh/github_rsa -T git@github.com
3. git clone github-user1:user1/project.git 
(github-user1指的是在config文件配置中Host对应的名称)
相当于git clone git@github.com:HudsonWu/linuxStudying.git
