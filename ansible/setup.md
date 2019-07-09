# 使用setup取得Managed node的facts

使用playbooks时, ansible会自动执行setup module以收集各个Managed node的facts

```
This module is automatically called by playbooks to gather useful variables about remote hosts that can be used in playbooks. 
It can also be executed directly by /usr/bin/ansible to check what variables are available to a host. 
Ansible provides many facts about the system, automatically.
```

## Ad-Hoc Commands

```
ansible all -m setup | less
ansible all -m setup -a "filter=ansible_distribution*"
ansible all -m setup -a "filter=ansible_pkg_mgr"
```

## Playbooks

```
$ vim setup_vim.yml
---
- name: Setup the vim
  hosts: all
  become: true
  tasks:
    # Debian, Ubuntu
    - name: install apt packages
      apt: name=vim state=present
      when: ansible_pkg_mgr == "apt"
    # CentOS
    - name: install yum packages
      yum: name=vim-minimal state=present
      when: ansible_pkg_mgr == "yum"
```
