# template, Template a file out to a remote server

+ Template are processed by the [Jinja2 templating language](http://jinja.pocoo.org/docs/)

## 简单实例

```
$ vi hello_world.txt.j2
Hello "{{ dynamic_word }}"

$ vi template_demo.yml
---
- name: Play the template module
  hosts: localhost
  vars:
    dynamic_word: "World"
  tasks:
    - name: generation the hello_world.txt file
      template:
        src: hello_world.txt.j2
        dest: /tmp/hello_world.txt
    - name: show file context
      command: cat /tmp/hello_world.txt
      register: result
    - name: print stdout
      debug:
        msg: ""

$ ansible-playbook template_demo.yml
$ ansible-playbook template_demo.yml -e "dynamic_word=ansible"
```

## 切换不同的环境

```
$ vi hello_world.txt.j2
Hello "{{ dynamic_word }}"

# vars/development.yml, vars/test.yml, vars/production.yml
$ cat vars/development.yml
dynamic_word: "development"

# cat template_demo2.yml
---
- name: Play the template module
  hosts: localhost
  vars:
    env: "development"
  vars_files:
    - vars/.yml
  tasks:
    - name: generation the hello_world.txt file
      template:
        src: hello_world.txt.j2
        dest: /tmp/hello_world.txt
    - name: show file context
      command: cat /tmp/hello_world.txt
      register: result
    - name: print stdout
      debug:
        msg: ""

$ ansible-playbook template_demo.yml -e "env=test"
```

## Examples

```
- name: Copy a version of named.conf that is dependent on the os
  template:
    src: named.conf_{{ ansible_os_family }}.j2
    dest: /etc/named.conf
    group: named
    setype: named_conf_t
    mode: 0640

- name: Create a DOS-style text file from a template
  template:
    src: config.ini.j2
    dest: /share/windows/config.ini
    newline_sequence: '\r\n'

- name: Update sshd configuration safely, avoid locking yourself out
  template:
    src: etc/ssh/sshd_config.j2
    dest: /etc/ssh/sshd_config
    owner: root
    group: root
    mode: '0600'
    validate: /usr/sbin/sshd -t -f %s
    backup: yes
```
