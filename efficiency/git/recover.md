# 修复 git reset --hard

```
$ git reflog show

4b6cf8e (HEAD -> master, origin/master, origin/HEAD) HEAD@{0}: reset: moving to origin/master
295f07d HEAD@{1}: pull: Merge made by the 'recursive' strategy.
7c49ec7 HEAD@{2}: commit: restore dependencies to the User model
fa57f59 HEAD@{3}: commit: restore dependencies to the Profile model
3431936 HEAD@{4}: commit (amend): restore admin
033f5c0 HEAD@{5}: commit: restore admin
ecd2c1d HEAD@{6}: commit: re-enable settings app

# the commit the HEAD to be pointed to is 7c49ec7 (restore dependencies to the User model)

$ git reset HEAD@{2}
```
