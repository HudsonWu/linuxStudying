ausearch, 搜索审计日志

> ausearch --message USER_LOGIN --success no --interpret  //系统登录失败
> ausearch -m ADD_USER -m DEL_USER -m ADD_GROUP -m USER_CHAUTHTOK -m DEL_GROUP -m CHGRP_ID -m ROLE_ASSIGN -m ROLE_REMOVE -i
// 搜索所有的账户, 群组, 角色变更
> ausearch --start 02/07/2017 --end 02/21/2017 -m SYSCALL -sv no -i  //指定时间段失败的系统调用
> ausearch -k passwd_changes | less
> ausearch -ua 1000 -i
