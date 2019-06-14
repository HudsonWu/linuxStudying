# 权限管理

授予用户的权限分全局层级权限、数据库层级权限、表层级别权限、列层级别权限、子程序层级权限

+ 全局层级, 适用于给定服务器中的所有数据库, 存储在mysql.user表中
    + grant all on *.*
    + revoke all on *.*
+ 数据库层级, 适用于给定数据库中的所有目标, 存储在mysql.db和mysql.host表中
    + grant all on db_name.*
    + revoke all on db_name.*
+ 表层级, 适用于给定表中的所有列, 存储在mysql.tables_priv表中
    + grant all on db_name.tbl_name
    + revoke all on db_name.tbl_name
+ 列层级, 适用于给定表中的单一列, 存储在mysql.columns_priv表中
    + grant select(id, col1) on db_name.tbl_name
+ 子程序层级
    + CREATE ROUTINE, ALTER ROUTINE, EXECUTE和GRANT权限适用于已存储的子程序
    + 这些权限可以被授予为全局层级和数据库层级
    + 除了CREATE ROUTINE外, 这些权限可以被授予为子程序层级, 并存储在mysql.procs_priv表中
    + grant execute on procedure db_name.tbl_name

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
