# firewalld

```
# public

## 内网之间可互相访问
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=172.18.0.0/16 accept'
## 常用服务, 端口
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --permanent --add-service=openvpn
firewall-cmd --permanent --add-port=8080
## 使配置立即生效
firewall-cmd --reload
# 检查文件/etc/firewalld/zones/public.xml

# docker
firewall-cmd --permanent --zone=trusted --change-interface=docker0
firewall-cmd --reload
```

## ansible

```
---
- name: stop iptables and disable iptables on boot
  service: name=iptables state=stopped enabled=no
  ignore_errors: true

- name: ensure firewalld installed
  yum: name=firewalld state=present

- name: enable firewalld
  service: name=firewalld state=started enabled=yes

- name: set public as default zone policy
  command: firewall-cmd --set-default-zone=public

- name: ensure private network is not blocked
  firewalld:
    rich_rule: 'rule family=ipv4 source address={{ item }} accept'
    permanent: true
    state: enabled
  with_items:
      - 172.16.24.0/24
      - 10.8.0.0/24
      - 10.8.1.0/24

- name: enable common services
  firewalld:
    service: '{{ item }}'
    permanent: true
    state: enabled
  with_items:
    - http
    - https
    - ssh
    - ntp
    - openvpn

- name: enable ports
  firewalld:
    port: '{{ item }}'
    permanent: true
    state: enabled
  with_items:
    - 58890/tcp
    - 58880/tcp
    - 5000/tcp
    - 8080/tcp
    - 8088/tcp
    - 8888/tcp

- name: enable docker interface
  firewalld:
    zone: trusted
    interface: docker0
    permanent: true
    state: enabled

- name: enable docker ports
  firewalld:
    port: '{{ item }}'
    permanent: true
    state: enabled
  with_items:
    - 4243/tcp

# 有些机器可能没有运行 dockerd，简单的通过 ignore_errors 来跳过
- name: restart docker daemon
  service: name=docker state=restarted
  ignore_errors: true

- name: reload firewalld
  service: name=firewalld state=reloaded

# 有时候会出现 firewalld 进程意外退出的情况，具体原因待查
- name: enable firewalld
  service: name=firewalld state=started enabled=yes
```
