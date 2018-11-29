## 撤销操作

1. 将指定文件在工作区的修改全部撤销
<pre>
git checkout -- file1
git checkout file1
1. 当file1文件修改后还没有提交到暂存区, 撤销修改就会回到和仓库区一样的状态
2. 当file1文件已经提交到暂存区, 又做了修改, 撤销修改就会回到和暂存区一样的状态
</pre>

2. 恢复某个commit的指定文件到暂存区和工作区
<pre>
git checkout cb71df2 file1
</pre>

3. 让单个文件回退到指定版本
<pre>
git reset a43215 file1  //暂缓区回退到指定commit, 工作区不变
git commit -m "revert old file because a error"  //提交到本地
git checkout file1  //更新到工作目录
git push origin master  //提交到远程仓库
</pre>

4. 版本回退
<pre>
//重置当前HEAD为指定commit, 但保持暂存区和工作区不变
git reset --keep a43215

//重置当前HEAD为指定commit, 同时重置暂存区和工作区
git reset --hard a43215

//重置当前HEAD为指定commit, 同时重置暂存区, 工作区不变
git reset a43215
</pre>

5. 撤销
<pre>
//新建一个commit, 用来撤销指定commit
git revert a43215
</pre>

6. git stash
<pre>
//暂时将未提交的变化移除, 稍后再移入
//保存当前工作进度, 会把暂存区和工作区的改动保存起来
git stash
git stash save 'message...'  //添加注释

git stash list  //显示保存进度的列表

//恢复最新的进度到工作区
//默认会把工作区和暂存区的改动都恢复到工作区
git stash pop
git stash pop --index  //恢复最新的进度到工作区和暂存区
git stash pop stash@{1}  //恢复指定的进度到工作区
通过git stash pop命令恢复进度后, 会删除当前进度

git stash apply stash@{1}  //除了不删除恢复的进度外, 和git stash pop一样
git stash drop stash@{1}  //删除一个存储的进度, 如果不指定stash_id, 则删除最新的存储进度
git stash clear  //删除所有存储的进度
</pre>
