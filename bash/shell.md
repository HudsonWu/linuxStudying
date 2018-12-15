# shell

```
echo $shell  //查看当前shell
cat /etc/shells  //查看系统中安装的shell
```

## chsh, 改变默认shell

```
-l, --list-shells  列出可以使用的shell
cat /etc/shells
-s  设置登录shell
```

```
chsh -l
chsh -s /usr/bin/fish
chsh -s /usr/bin/fish user_2
```

