# git stash

```
# 查看现有stash
git stash list

# 把所有未提交的修改都保存起来
git stash save "your message"

# 恢复缓存的工作目录
## 这个命令会将堆栈中第一个stash删除，并将对应修改
## 应用到当前的工作目录
git stash pop

# 将堆栈中的stash多次应用到工作目录中，但并不删除stash拷贝
## 可以通过名字指定使用哪个stash, 默认使用最近的stash
git stash apply

# 移除stash
## 后面可以跟stash名字
git stash drop

# 删除所有缓存的stash
git stash clear

# 查看stash的diff
## 后面可以跟stash名字
## 添加-p或--patch可以查看全部diff
git stash show
```

默认情况下，git stash会缓存下列文件：
+ 添加到暂存区的修改（staged changes）
+ Git跟踪的但并未添加到暂存区的修改（unstaged changes）

不会缓存以下文件：
+ 在工作目录中新的文件（untracked files）
+ 被忽略的文件（ignored files）

git stash命令提供了参数用于缓存上面两种类型的文件。使用-u或者--include-untracked可以stash untracked文件。使用-a或者--all命令可以stash当前目录下的所有修改

## 从stash创建分支

如果你储藏了一些工作，暂时不去理会，然后继续在你储藏工作的分支上工作，你在重新应用工作时可能会碰到一些问题。如果尝试应用的变更是针对一个你那之后修改过的文件，你会碰到一个归并冲突并且必须去化解它。如果你想用更方便的方法来重新检验你储藏的变更，你可以运行 git stash branch，这会创建一个新的分支，检出你储藏工作时的所处的提交，重新应用你的工作，如果成功，将会丢弃储藏。

```
git stash branch testchanges
```
