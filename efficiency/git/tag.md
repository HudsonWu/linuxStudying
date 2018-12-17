## 显示标签
```
git tag  //列出现有标签
git tag -l 'v1.4.2.*'  //列出1.4.2系列版本
git show v1.4  //查看相应标签的版本信息和提交对象
git checkout -b test v1.4  //新建一个指向v1.4标签的分支
```

## 新建标签

1. 轻量级标签(lightweight)
就像是个不会变化的分支, 实际上它就是个指向特定提交对象的引用
```
git tag v1.4-lw  //在当前commit创建一个轻量级标签
git tag v1.3-lw 9cdcc25 //在指定commit创建一个轻量级标签
```

2. 含附注标签(annotated)
实际上是存储在仓库中的一个独立对象, 它有自身的校验和信息, 包含标签的名字, 电子邮件地址和日期, 以及标签说明
```
git tag -a v1.4 -m 'my version 1.4'  //-a, annotated, 创建一个含附注类型的标签
git tag -s v1.5 -m 'my signed 1.5 tag'  //-s, signed, 使用GPG来签署标签
git tag -a v1.2 9fceb02  //给指定提交添加标签
```

## 验证标签
```
git tag -v v1.4.2.1  //-v, verify, 验证已经签署的标签
```

## 推送标签
默认情况下, git push不会把标签传送到远端服务器, 只有通过显式命令才能分享标签到远端仓库
```
git push origin v1.5  //推送指定标签
git push origin --tags  //一次推送所有本地新增的标签
```

## 删除标签
```
git tag -d v1.3  //删除本地标签
git push origin :refs/tags/v1.3  //删除远程标签
```

## 标签的更新
```
git fetch  //获取所有的提交以及标签的更新
git fetch origin --tags  //仅仅获取标签的更新
```

## 查看远程仓库的标签
```console
$ git ls-remote --tags
From git@github:someone/project01.git
a2f799ac3b27a6aef69d38357deb5d145a9407ad    refs/tags/1.0.0
5814a19e66760629dd153836586cc9f8eadb78ae    refs/tags/1.0.0^{}
0ee6bf7e00c9fa256231e4ef387dfab456e4ee28    refs/tags/1.0.1
6c637a92acafbcde94609e93e6f5c112fa2d73d5    refs/tags/1.0.1^{}
```
`refs/tags/1.0.1^{}`表示1.0.1是含附注的标签, 参数`--tags`可以简化为`-t`
