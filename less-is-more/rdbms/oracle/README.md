# oracle

## 查看Oracle数据库的用户名和密码

三个默认的用户名和密码:
  + sys    change_on_install
  + system    manager
  + scott    tiger

```
# 以sys登录 (超级用户sysdba)
sqlplus / as sysdba

show parameter service_name

alter user yourusername account unlock;  # 解除锁定
alter user yourusername identified by yourpassword;  # 修改密码

select distinct owner from all_objects;  # 查看当前用户

select username from dba_users;  # 查看数据库中的所有用户名
```

## 数据迁移

+ exp/imp, 最传统, 也是最保险的迁移方式, 时间较长
+ Expdp/impdp数据泵, 速度比较快
+ Rman, 其原理只是备份和恢复

### 数据库编码

```
sqlplus / as sysdba

# 关闭数据库
shutdown immediate;

# 以mount打开数据库
startup mount;

# 设置session
alter system enable restricted session;
alter system set job_queue_processes=0;
alter system set aq_tm_processes=0;

# 启动数据库
alter database open;

# 修改字符集
ALTER DATABASE character set INTERNAL_USE ZHS16GBK;

# 关闭并重新启动
shutdown immediate;
startup;

# 检查数据库字符集
select userenv('language') from dual;
```

### exp/imp工具, .dmp文件

```
带参数:
rows=y    带数据导出导入
rows=n    不带数据的导出导入, 只移植结构

exp user/pasword@dbServerName owner=user tables=(table1,table2,table3) rows=y file=c:\2.dmp
imp user2/pasword@dbServerName2 fromuser=user touser=user2 file=c:\2.dmp

exp tianzhi_smart/tianzhi_smart@192.168.56.60:1521/orcl file='E:\tianzhi_smart.dmp';
imp tianzhi_smart/tianzhi_smart@192.168.10.129:1521/orcl file='E:\tianzhi_smart.dmp' full=y;
```

#### 导入导出

```
select tablespace_name from dba_tablespaces;  # 查看数据库的表空间
select userenv('language') from dual;  # 查看数据库字符集

# 创建表空间
CREATE TABLESPACE DSMS DATAFILE '/home/oracle/app/oracle/data/DSMS.dbf' SIZE 32M AUTOEXTEND ON NEXT 32M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL;


# 导出
exp system/oracle file=full.dmp log=full.log buffer=10000000 full=y

# 导入
export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK  # 设置导入编码
imp system/oracle file=full.dmp log=full.log buffer=100000000 full=y ignore=y
```

```
权限不足时:
grant create trigger to scott;
```

