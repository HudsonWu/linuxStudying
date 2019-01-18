## MongoDB 用户添加, 修改, 删除, 权限追加

现在需要创建一个帐号, 该账号需要有grant权限, 即: 账号管理的授权权限. 注意一点, 帐号是跟着库走的, 所以在指定库里授权, 必须也在指定库里验证(auth)

```mongo
> use admin
switched to db admin
> db.createUser( { user: "dba",pwd: "dba",roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]})
Successfully added user: {
    "user" : "dba",
    "roles" : [
        {
            "role" : "userAdminAnyDatabase",
            "db" : "admin"
        }
    ]
}
```

```
user: 用户名
pwd: 密码
roles: 指定用户的角色, 可以用一个空数组给新用户设定空角色; 
       在roles字段,可以指定内置角色和用户定义的角色

Built-In Roles（内置角色）: 
    1. 数据库用户角色: read、readWrite;
    2. 数据库管理角色: dbAdmin、dbOwner、userAdmin; 
    3. 集群管理角色: clusterAdmin、clusterManager、clusterMonitor、hostManager; 
    4. 备份恢复角色: backup、restore; 
    5. 所有数据库角色: readAnyDatabase、readWriteAnyDatabase、userAdminAnyDatabase、dbAdminAnyDatabase
    6. 超级用户角色: root  
    // 这里还有几个角色间接或直接提供了系统超级用户的访问（dbOwner 、userAdmin、userAdminAnyDatabase）
    7. 内部角色: __system

具体角色: 
Read: 允许用户读取指定数据库
readWrite: 允许用户读写指定数据库
dbAdmin: 允许用户在指定数据库中执行管理函数, 如索引创建、删除, 查看统计或访问system.profile
userAdmin: 允许用户向system.users集合写入, 可以找指定数据库里创建、删除和管理用户
clusterAdmin: 只在admin数据库中可用, 赋予用户所有分片和复制集相关函数的管理权限. 
readAnyDatabase: 只在admin数据库中可用, 赋予用户所有数据库的读权限
readWriteAnyDatabase: 只在admin数据库中可用, 赋予用户所有数据库的读写权限
userAdminAnyDatabase: 只在admin数据库中可用, 赋予用户所有数据库的userAdmin权限
dbAdminAnyDatabase: 只在admin数据库中可用, 赋予用户所有数据库的dbAdmin权限. 
root: 只在admin数据库中可用. 超级账号, 超级权限
```

## 添加用户, db.createUser()

1.如果没有test数据库, 来创建一个
```mongo
> show dbs;
admin  0.000GB
local  0.000GB
> use test
switched to db test
> db.test.insert({a:1,b:2,c:3})
WriteResult({ "nInserted" : 1 })
> show dbs
admin  0.000GB
local  0.000GB
test   0.000GB
>
```

2.给test创建一个只读用户
```mongo
> use test
switched to db test
> db.createUser({user:"testRead",pwd:"123456",roles:[{role:"read",db:"test"}]})
Successfully added user: {
        "user" : "testRead",
        "roles" : [
                {
                        "role" : "read",
                        "db" : "test"
                }
        ]
}
```

3.我们切换到testRead用户进行测试

```mongo
> use test
switched to db test
> show tables
test
> db.test.insert({d:3333});
WriteResult({
        "writeError" : {
                "code" : 13,
                "errmsg" : "not authorized on test to execute command { insert:
\"test\", documents: [ { _id: ObjectId('59b74fe6542a7d19a60fe821'), d: 3333.0 }
], ordered: true }"
        }
})
> db.test.find()
{ "_id" : ObjectId("59b743e82dd2de6390db71bc"), "a" : 1, "b" : 2, "c" : 3 }
{ "_id" : ObjectId("59b7493181afcaab7c1faeff"), "a" : 22 }
```
注意: 如果添加了权限发现还是可以添加数或者可以显示admin数据库的话, 应该是服务端启动的时候没有添加验证, 下面为添加验证的启动: 
```sh
mongod --dbpath "D:\\MongoDB\db" --logpath "D:\\MongoDB\\log\\mongodb.log" --logappend --auth
```

## 查看用户, db.system.users.find()

```mongo
> use admin
switched to db admin
> db.system.users.find()
{ "_id" : "admin.root", "user" : "root", "db" : "admin", "credentials" : { "SCRA
M-SHA-1" : { "iterationCount" : 10000, "salt" : "Fvxditujnok3+9JG9Kb33w==", "sto
redKey" : "vX1plM78Iz0Yipd2I+X95vWGRMY=", "serverKey" : "BT2E6639MQE++WIWIS1gLRv
oY90=" } }, "roles" : [ { "role" : "userAdminAnyDatabase", "db" : "admin" } ] }
{ "_id" : "admin.dba", "user" : "dba", "db" : "admin", "credentials" : { "SCRAM-
SHA-1" : { "iterationCount" : 10000, "salt" : "lVXxxJUG14VUQnR2dEUK4A==", "store
dKey" : "8B+5V+ZY88PYKlq18nyb+wVlR2w=", "serverKey" : "iWLBzuihOOuMO0xJ0+BuohISV
f4=" } }, "roles" : [ { "role" : "userAdminAnyDatabase", "db" : "admin" } ] }
{ "_id" : "admin.testRead", "user" : "testRead", "db" : "admin", "credentials" :
 { "SCRAM-SHA-1" : { "iterationCount" : 10000, "salt" : "LXM1+WLuMrU2TEIo443EgA=
=", "storedKey" : "gEXfO4CCaqmxrejaJ/O+m2zbUnw=", "serverKey" : "AIm4itUF3d/e4bV
Q+abQscK2ZCo=" } }, "roles" : [ { "role" : "read", "db" : "test" } ] }
```

## 修改用户, db.updateUser()

```mongo
db.updateUser("testRead",{pwd:"111111",roles:[{role:"read",db:"test"}]})
```

## 追加权限, db.grantRolesToUser()

```mongo
> db.grantRolesToUser("testRead",[{role:"readWrite",db:"test"}])
> db.system.users.find()
{ "_id" : "admin.root", "user" : "root", "db" : "admin", "credentials" : { "SCRA
M-SHA-1" : { "iterationCount" : 10000, "salt" : "Fvxditujnok3+9JG9Kb33w==", "sto
redKey" : "vX1plM78Iz0Yipd2I+X95vWGRMY=", "serverKey" : "BT2E6639MQE++WIWIS1gLRv
oY90=" } }, "roles" : [ { "role" : "userAdminAnyDatabase", "db" : "admin" } ] }
{ "_id" : "admin.dba", "user" : "dba", "db" : "admin", "credentials" : { "SCRAM-
SHA-1" : { "iterationCount" : 10000, "salt" : "lVXxxJUG14VUQnR2dEUK4A==", "store
dKey" : "8B+5V+ZY88PYKlq18nyb+wVlR2w=", "serverKey" : "iWLBzuihOOuMO0xJ0+BuohISV
f4=" } }, "roles" : [ { "role" : "userAdminAnyDatabase", "db" : "admin" } ] }
{ "_id" : "admin.testRead", "user" : "testRead", "db" : "admin", "credentials" :
 { "SCRAM-SHA-1" : { "iterationCount" : 10000, "salt" : "aHsLKbsMkklKutPqrpH4RA=
=", "storedKey" : "cpvaIklo7JypIU2RstJL1pQHTCE=", "serverKey" : "gPuCEHV2tUnddfG
FoXA9s6Armdk=" } }, "roles" : [ { "role" : "readWrite", "db" : "test" }, { "role
" : "read", "db" : "test" } ] }
```

## 删除用户, db.dropUser()

```mongo
> use admin
switched to db admin
> db.dropUser("testRead")
true
> db.system.users.find();
{ "_id" : "admin.root", "user" : "root", "db" : "admin", "credentials" : { "SCRA
M-SHA-1" : { "iterationCount" : 10000, "salt" : "Fvxditujnok3+9JG9Kb33w==", "sto
redKey" : "vX1plM78Iz0Yipd2I+X95vWGRMY=", "serverKey" : "BT2E6639MQE++WIWIS1gLRv
oY90=" } }, "roles" : [ { "role" : "userAdminAnyDatabase", "db" : "admin" } ] }
{ "_id" : "admin.dba", "user" : "dba", "db" : "admin", "credentials" : { "SCRAM-
SHA-1" : { "iterationCount" : 10000, "salt" : "lVXxxJUG14VUQnR2dEUK4A==", "store
dKey" : "8B+5V+ZY88PYKlq18nyb+wVlR2w=", "serverKey" : "iWLBzuihOOuMO0xJ0+BuohISV
f4=" } }, "roles" : [ { "role" : "userAdminAnyDatabase", "db" : "admin" } ] }
```

