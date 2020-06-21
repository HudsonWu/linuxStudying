# grains

grains是存储在minions上的关于系统属性的一些信息

```
# 获取所有grains数据
salt 'minion01' grains.items

# 获取网络接口的一些信息
salt 'minion01' grains.item ip_interfaces fqdn
```

## 在minion上配置grains

有多种方法可以配置grains，可以在minion的默认配置文件/etc/salt/minion中配置，也可以将grains配置在一个单独的文件/etc/salt/grains中。

/etc/salt/minion文件配置示例:
```
grains:
  environment: development
  location: datacenter1
  role:
    - webserver
    - memcache
```

/etc/salt/grains文件配置示例:
```
environment: development
location: datacenter1
role:
  - webserver
  - memcache
```

获取配置的grains:
```
salt 'minion01' grains.item environment location server_type
```
