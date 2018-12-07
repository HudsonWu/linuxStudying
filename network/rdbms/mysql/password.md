1. mysqladmin command to change root password
to set up a root password for the first time:
  mysqladmin -u root password newpass
(mysql_secure_connection)
to change a root password:
  mysqladmin -u root -p oldpassword newpass
2. update or change password
mysql stores usernames and passwords in the user table inside the MYSQL database
  use mysql;
  update user set password=PASSWORD("newpass") where User='username';
  flush privileges;
3. recover mysql root password
  systemctl stop mysql
  mysqld_safe --skip-grantt-tables &
  mysql -u root
  use mysql;
  update user set password=PASSWORD("newpass") where User='root';
  flush privileges;
  quit
  systemctl stop mysql
  systemctl start mysql
  mysql -u root -p