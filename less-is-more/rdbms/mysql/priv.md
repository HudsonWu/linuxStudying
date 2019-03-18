# 权限管理

1. mysql查看用户权限的命令
```sql
//使用mysql grants
show grants for username@localhost;

//直接通过mysql select查询语句
select * from mysql.user where user='test' and host='127.0.0.1' \G;
select distinct concat('User:''',user,'''@''',host,''';') as query from mysql.user;
```

2. 给用户加权限
```sql
grant all privileges on  *.* to 'test'@'%' identified by 'passwd';
grant all on db.table to 'username'@'host' identified by 'password';
flush privileges;
```

3. show命令
```sql
show create database dbname;  //查看dbname创建时用到的一些参数
show create table tablename;  //查看tablename创建时用到的一些参数
show grants for username;     //查看username的权限
```

4. 创建数据库
```sql
CREATE DATABASE mydatabase CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE mydatabase CHARACTER SET utf8 COLLATE utf8_general_ci;
```
