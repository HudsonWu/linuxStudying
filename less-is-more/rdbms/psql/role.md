# 角色属性 (Role Attributes)

```
login  只有具有LOGIN属性的角色可以用作数据库连接的初始角色名
superuser  数据库超级用户
createdb  创建数据库权限
createrole  允许创建或删除其他普通用户角色(除了超级用户)
replication  做流复制的时候用到的一个用户属性, 一般单独设定
inherit  用户组对组员的一个继承标志, 成员可以继承用户组的权限特性
```

1. 创建角色并赋予权限
```sql
CREATE ROLE bella CREATEDB; //创建bella角色并赋予CREATEDB的权限
CREATE ROLE renee CREATEDB PASSWORD 'abc123' LOGIN; //创建角色renee并赋予其创建数据库及带有密码登录的属性
```

2. 给已存在用户赋予权限
```sql
ALTER ROLE name RENAME TO new_name; 
ALTER ROLE bella WITH LOGIN; //赋予bella角色登录权限
ALTER ROLE davia WITH PASSWORD 'ufo456'; //赋予david带密码登录权限
ALTER ROLE sandy VALID UNTIL '2018-12-11'; //设置sandy角色的有效期
```

3. 组角色
首先创建一个代表组的权限, 之后再将该角色的membership权限赋给独立的角色
```sql
CREATE ROLE father login nosuperuser nocreatedb nocreaterole noinherit encrypted password 'abc123'; //创建组角色
GRANT CONNECT ON DATABASE test to father; //给father角色赋予数据库test连接权限
GRANT USAGE ON SCHEMA public to father;
GRANT SELECT on public.emp to father; //给角色father赋予emp表的查询权限
CREATE ROLE son1 login nosuperuser nocreatedb nocreaterole inherit encrypted password 'abc123'; //创建son1角色, 并开启inherit属性
GRANT father to son1; //将father角色赋给son1
CREATE ROLE son2 login nosuperuser nocreatedb nocreaterole inherit encrypted password 'abc123' in role father; //创建用户的时候赋予角色
```
