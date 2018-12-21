# git 命令集

## git rev-parse

```
git rev-parse --symbolic --branches  //查看所有分支
git rev-parse --symbolic --tags  //查看所有标签
git rev-parse --symbolic --glob=refs/*  //查看所有引用
git rev-parse HEAD  //查看head对应的sha1哈希值
git rev-parse HEAD master //查看多个引用的哈希值

git rev-parse :example.py  //查看暂存区example.py文件的sha1哈希值
git rev-parse HEAD:example.py  //查看仓库区example.py文件的sha1哈希值
git rev-parse :example.py HEAD:example.py  //查看暂存区和仓库区examply.py文件的sha1哈希值
git rev-parse :/"commit message"  //在提交日志中根据字符串查找commit对象
git rev-parse HEAD@{0} MASTER@{0}  //reflog相关语法
```

## git rev-list

```
git rev-list --oneline A  //A版本提交历史
git rev-list --oneline D F  //多个版本历史并集
git rev-list --oneline ^G D  //排除^版本的提交历史
git rev-list --oneline G..D  //相当于 ^G D
git rev-list --oneline B...C  //排除BC共同部分
git rev-list --oneline B^@  //提交历史, 排除自身
git rev-list --oneline B^!  //提交本身
```

## git diff

```
git diff <commit1> <commit2> -- <paths>
git diff <path1> <path2>
git diff --word-diff  //逐字比较
```

## git blame

```
git blame README  //逐行显示文件提交版本, 提交人, 提交时间
git blame -L 6,+5 README  //只查看某几行
```
