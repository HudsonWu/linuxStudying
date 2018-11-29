## git checkout

1. 将指定文件在工作区的修改全部撤销
<pre>
git checkout -- readme.txt
1. 当readme.txt文件修改后还没有提交到暂存区, 撤销修改就会回到和仓库区一样的状态
2. 当readme.txt文件已经提交到暂存区, 又做了修改, 撤销修改就会回到和暂存区一样的状态
</pre>

2. 让单个文件回退到指定版本
<pre>
git reset a43215 readme.txt  //回退到指定版本
git commit -m "revert old file because a error"  //提交到本地
git checkout readme.txt  //更新到工作目录
git push origin master  //提交到远程仓库
</pre>
