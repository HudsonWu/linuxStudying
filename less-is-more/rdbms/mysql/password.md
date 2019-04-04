# mysql密码设置

1. mysqladmin command to change root password

```sh
//to set up a root password for the first time
mysqladmin -u root password newpass

//to change a root password
mysqladmin -u root -p oldpassword newpass
```

2. update or change password

mysql stores usernames and passwords in the user table inside the MYSQL database

```sql
use mysql;
update user set password=PASSWORD("newpass") where User='username';
flush privileges;
```

```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
```

3. recover mysql root password

```sh
systemctl stop mysql
mysqld_safe --skip-grantt-tables &
mysql -u root
```
```sql
use mysql;
update user set password=PASSWORD("newpass") where User='root';
flush privileges;
quit
```
```sh
systemctl stop mysql
systemctl start mysql
mysql -u root -p
```
