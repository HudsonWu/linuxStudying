# mysql密码设置

## mysqladmin

```sh
# 初次设置密码
mysqladmin -u root password newpass

//修改root密码
mysqladmin -u root -p oldpassword newpass
```

## mysql database

mysql stores usernames and passwords in the user table inside the MYSQL database

```sql
use mysql;
update user set authentication_string=PASSWORD("newpass") where User='username';
flush privileges;
```

```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
```

## 重置密码

### 设置跳过密码验证

```sh
systemctl stop mysql
mysqld_safe --skip-grant-tables &
```

或者修改my.ini文件
```
# vi /etc/my.cnf
[mysqld]
skip-grant-tables
# systemctl restart mysql
```

### 修改密码

```sql
# mysql -u root
use mysql;
update user set password=PASSWORD("newpass") where User='root';
# update mysql.user set authentication_string=password('yellowcong') where user='root' and Host = 'localhost';
flush privileges;
quit
```

```sh
# 去除skip-grant-tables后重启
systemctl restart mysql
mysql -u root -p
```

## 允许mysql远程访问

### 改表

```sql
use mysql;
update user set host='%' where user = 'root';
select host, user from user;
```

### 授权

```sql
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
flush privileges
```
