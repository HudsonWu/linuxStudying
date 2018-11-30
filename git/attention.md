1. git rm
<pre>
//删除工作区文件, 并将这次删除放入暂存区
git rm file1 file2

//停止跟踪指定文件, 但该文件会保留在工作区
git rm --cached file

//删除readme.txt的跟踪, 并且删除本地文件
git rm -f readme.txt 

//改名文件, 并且讲这个改名放入暂存区
git mv file_original file_renamed
</pre>

2. git add
<pre>
//监控工作区的状态树, 会把工作时的所有变化提交到暂存区
//包括文件内容修改(modified)以及新文件(new), 但不包括被删除的文件
git add .  //添加当前目录的所有文件到暂存区

//仅监控已经被add的文件(即tracked file)
//会将被修改的文件提交到暂存区, 不会提交新文件(untracked file)
git add -u

git add -A    //git add --all的缩写, 上面两个功能的合集
</pre>

3. crlf和lf
<pre>
git config --global core autocrlf true
true  -->  添加文件到仓库时, git 视其为文本文件, 将crlf变成lf
false  -->  line-endings不做转换操作, 文本文件保持原样
input  -->  添加文件到仓库时将crlf变成lf, check代码时也是lf, 在windows系统下不使用这个设置
</pre>

4. 远程覆盖本地
<pre>
git fetch --all
git reset --hard origin/master
</pre>

5. 测试ssh是否成功连接
<pre>
ssh -vT git@github.com
</pre>

6. 查看master分支所有提交
<pre>
git rev-list master
//显示前10个
git rev-list master --max-count=10
</pre>

7. --depth
<pre>
//--depth, 解决内容过多时git clone花费时间长的问题
//depth用于指定克隆深度, 为1即表示只克隆最近一次commit
git clone --depth 1 https:/github.com/someone/example.git

//拉取指定分支
git remote set-branches origin 'remote_branch_name'
git fetch --depth 1 origin remote_branch_name
git checkout remote_branch_name
</pre>

8. 修改最近一次的commit msg
<pre>
git commit --amend
</pre>