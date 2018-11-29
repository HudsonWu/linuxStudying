1. compose安装
在安装compose之前, 确保已经安装了docker1.3或以上版本
> curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m`> /usr/local/bin/docker-compose
> chmod +x /usr/local/bin/docker-compose

2. compose命令补全
确保bash-completion已经安装, 然后将compose的completion脚本放在/etc/bash_completion.d/下:
> curl -L https://raw.githubusercontent.com/docker/compose/1.1.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
下次登录时, Completion功能就可以使用了

