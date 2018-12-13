## 显示标签
<pre>
git tag  //列出现有标签
git tag -l 'v1.4.2.*'  //列出1.4.2系列版本
git show v1.4  //查看相应标签的版本信息和提交对象
git checkout -b test v1.4  //新建一个指向v1.4标签的分支
</pre>

## 新建标签

1. 轻量级标签(lightweight)
就像是个不会变化的分支, 实际上它就是个指向特定提交对象的引用
<pre>
git tag v1.4-lw  //在当前commit创建一个轻量级标签
git tag v1.3-lw 9cdcc25 //在指定commit创建一个轻量级标签
</pre>

2. 含附注标签(annotated)
实际上是存储在仓库中的一个独立对象, 它有自身的校验和信息, 包含标签的名字, 电子邮件地址和日期, 以及标签说明
<pre>
git tag -a v1.4 -m 'my version 1.4'  //-a, annotated, 创建一个含附注类型的标签
git tag -s v1.5 -m 'my signed 1.5 tag'  //-s, signed, 使用GPG来签署标签
git tag -a v1.2 9fceb02  //给指定提交添加标签
</pre>

## 验证标签
<pre>
git tag -v v1.4.2.1  //-v, verify, 验证已经签署的标签
</pre>

## 推送标签
默认情况下, git push不会把标签传送到远端服务器, 只有通过显式命令才能分享标签到远端仓库
<pre>
git push origin v1.5  //推送指定标签
git push origin --tags  //一次推送所有本地新增的标签
</pre>

## 删除标签
<pre>
git tag -d v1.3  //删除本地标签
git push origin :refs/tags/v1.3  //删除远程标签
</pre>
