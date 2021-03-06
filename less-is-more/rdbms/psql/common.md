# postgresql

postgresql初次安装时, 默认生成了一个名为postgres的数据库和一个名为postgres的数据库用户, 同时还生成了一个名为postgres的linux系统用户

## 添加新用户和新数据库

1. 使用PostgreSQL控制台
```sh
sudo adduser hudson    # 新建一个linux新用户
sudo su - postgres    # 切换到postgres用户
psql    # 登录PostgreSQL控制台
```
```sql
\password postgres    //为postgres用户设置一个密码
CREATE USER hudson WITH PASSWORD 'password';    //创建数据库用户，并设置密码
CREATE DATABASE testdb OWNER hudson;    //创建用户数据库，指定所有者为hudson
GRANT ALL PRIVILEGES ON DATABASE testdb to hudson;    //将testdb数据库的所有权限都赋予hudson
\q    //退出控制台
```

2. 使用shell命令行
PostgreSQL提供了命令行程序createuser和createdb
```sh
sudo -u postgres createuser --superuser hudson    # 创建数据库用户hudson，并指定其为超级用户
sudo -u postgres psql
```
```sql
\password password
\q
```
```sh
sudo -u postgres createdb -O hudson testdb    # 创建数据库testdb，并指定所有者为hudson
```

## 登录数据库
```sh
psql -U hudson -d testdb -h 127.0.0.1 -p 5432
```
若linux系统用户和postgresql存在同名用户，则可以直接使用命令`psql testdb`

```sh
psql testdb < testdb.sql    # 恢复外部数据
```

## 控制台命令
```
\h  查看sql命令的解释，如\h select
\?  查看psql命令列表
\l  列出所有数据库
\c [database_name]  连接其他数据库
\d  列出当前数据库的所有表格
\d [table_name]  列出某一张表格的结构
\du  列出所有用户
\e  打开文本编辑器
\conninfo  列出当前数据库和连接的信息
```

## 数据库操作
```sql
CREATE TABLE user_tb1(name VARCHAR(20),signup_date DATE);  // 创建新表
INSERT INTO user_tb1(name,signup_date) VALUES('Lancy','2017-11-11');  // 插入数据
SELECT * FROM user_tb1;  // 选择记录
UPDATE user_tb1 set name='aqing' WHERE name='Lancy';  // 更新数据
DELETE FROM user_tb1 WHERE name='Lucy';  // 删除记录
ALTER DATABASE abc RENAME TO cba;  // 数据库重命名
ALTER TABLE user_tb1 ADD email VARCHAR(40);  // 添加栏位
ALTER TABLE user_tb1 ALTER COLUMN signup_date SET NOT NULL;  // 更新结构
ALTER TABLE user_tb1 RENAME COLUMN signup_date TO signup;  // 更名栏位
ALTER TABLE user_tb1 DROP COLUMN email;  // 删除栏位
ALTER TABLE user_tb1 RENAME backup_tb1;  // 表格更名
DROP TABLE IF EXISTS backup_tb1;  // 删除表格
```

## PostgreSQL工具
1. pgAdmin是PostgreSQL的免费开源图形用户界面管理工具
2. phpPgAdmin 用php编写的PostgreSQL的基于Web的管理工具
3. pgFouine 一个日志分析器，可以从PostgreSQL日志文件创建报告
