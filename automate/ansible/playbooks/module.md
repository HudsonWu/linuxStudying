# module

+ [Module Index](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html)

## command, Execute commands on targets

`command module`是个可以在远端执行指令的模块, 
不支持变量(variables, 如$HOME)和操作符(operations, `<`, `>`, `|`, `;`, `&`等)

```
- name: return motd to registered var
  command: cat /etc/motd
  register: mymotd

- name: Run command if /path/to/database does not exist (without 'args').
  command: /usr/bin/make_database.sh db_user db_name creates=/path/to/database

# 'args' is a task keyword, passed at the same level as the module
- name: Run command if /path/to/database does not exist (with 'args').
  command: /usr/bin/make_database.sh db_user db_name
  args:
    creates: /path/to/database

- name: Change the working directory to somedir/ and run the command as db_owner if /path/to/database does not exist.
  command: /usr/bin/make_database.sh db_user db_name
  become: yes
  become_user: db_owner
  args:
    chdir: somedir/
    creates: /path/to/database

# 'argv' is a parameter, indented one level from the module
- name: Use 'argv' to send a command as a list - leave 'command' empty
  command:
    argv:
      - /usr/bin/make_database.sh
      - Username with whitespace
      - dbname with whitespace

- name: safely use templated variable to run command. Always use the quote filter to avoid injection issues.
  command: cat {{ myfile|quote }}
  register: myoutput
```

## shell, Execute shell commands on targets

`shell module`是可以在远程用/bin/sh执行指令的指令模块

```
- name: Change the working directory to somedir/ before executing the command.
  shell: somescript.sh >> somelog.txt
  args:
    chdir: somedir/

# You can also use the 'args' form to provide the options.
- name: This command will change the working directory to somedir/ and will only run when somedir/somelog.txt doesnt exist.
  shell: somescript.sh >> somelog.txt
  args:
    chdir: somedir/
    creates: somelog.txt

- name: Run a command that uses non-posix shell-isms (in this example /bin/sh doesnt handle redirection and wildcards together but bash does)
  shell: cat < /tmp/*txt
  args:
    executable: /bin/bash

- name: Run a command using a templated variable (always use quote filter to avoid injection)
  shell: cat {{ myfile|quote }}

# You can use shell to run other executables to perform actions inline
- name: Run expect to wait for a successful PXE boot via out-of-band CIMC
  shell: |
    set timeout 300
    spawn ssh admin@{{ cimc_host }}

    expect "password:"
    send "{{ cimc_password }}\n"

    expect "\n{{ cimc_name }}"
    send "connect host\n"

    expect "pxeboot.n12"
    send "\n"

    exit 0
  args:
    executable: /usr/bin/expect
  delegate_to: localhost

# Disabling warnings
- name: Using curl to connect to a host via SOCKS proxy (unsupported in uri). Ordinarily this would throw a warning.
  shell: curl --socks5 localhost:9000 http://www.ansible.com
  args:
    warn: no
```

## copy, Copy files to remote locations

```
- name: Copy file with owner and permissions
  copy:
    src: /srv/myfiles/foo.conf
    dest: /etc/foo.conf
    owner: foo
    group: foo
    mode: '0644'

- name: Copy a new "ntp.conf" file into place, backing up the original if it differs from the copied version
  copy:
    src: /mine/ntp.conf
    dest: /etc/ntp.conf
    owner: root
    group: root
    mode: '0644'
    backup: yes

- name: Copy a new "sudoers" file into place, after passing validation with visudo
  copy:
    src: /mine/sudoers
    dest: /etc/sudoers
    validate: /usr/sbin/visudo -cf %s

- name: Copy a "sudoers" file on the remote machine for editing
  copy:
    src: /etc/sudoers
    dest: /etc/sudoers.edit
    remote_src: yes
    validate: /usr/sbin/visudo -cf %s

- name: Copy using inline content
  copy:
    content: '# This file was moved to /etc/other.conf'
    dest: /etc/mine.conf

- name: If follow=yes, /path/to/file will be overwritten by contents of foo.conf
  copy:
    src: /etc/foo.conf
    dest: /path/to/link  # link to /path/to/file
    follow: yes

- name: If follow=no, /path/to/link will become a file and be overwritten by contents of foo.conf
  copy:
    src: /etc/foo.conf
    dest: /path/to/link  # link to /path/to/file
    follow: no
```

```
mode: '0644'
# using symbolic representation
mode: u=rw,g=r,o=r
# adding some permissions and removing others
mode: u+rw,g-wx,o-rwx
```

## file, Manage files and file properties

`file module`是在远程创建和删除文件(file), 目录(directory), 软链接(symlinks)的文件模块

```
- name: Change file ownership, group and permissions
  file:
    path: /etc/foo.conf
    owner: foo
    group: foo
    mode: '0644'

- name: Create a symbolic link
  file:
    src: /file/to/link/to
    dest: /path/to/symlink
    owner: foo
    group: foo
    state: link

- name: Create two hard links
  file:
    src: '/tmp/{{ item.src }}'
    dest: '{{ item.dest }}'
    state: hard
  with_items:
    - { src: x, dest: y }
    - { src: z, dest: k }

- name: Touch a file, but dont change times this makes the task idempotent
  file:
    path: /etc/foo.conf
    state: touch
    mode: u+rw,g-wx,o-rwx
    modification_time: preserve
    access_time: preserve

- name: Create a directory if it does not exist
  file:
    path: /etc/some_directory
    state: directory
    mode: '0755'

- name: Update modification and access time of given file
  file:
    path: /etc/some_file
    state: file
    modification_time: now
    access_time: now

- name: Set access time based on seconds from epoch value
  file:
    path: /etc/another_file
    state: file
    access_time: '{{ "%Y%m%d%H%M.%S" | strftime(stat_var.stat.atime) }}'

- name: Recursively change ownership of a directory
  file:
    path: /etc/foo
    state: directory
    recurse: yes
    owner: foo
    group: foo
```

## lineinfile, Manage lines in text files

`lineinfile module`是个可用正则表达式对文件进行插入或取代的文件模块

```
# NOTE: Before 2.3, option 'dest', 'destfile' or 'name' was used instead of 'path'
- name: Ensure SELinux is set to enforcing mode
  lineinfile:
    path: /etc/selinux/config
    regexp: '^SELINUX='
    line: SELINUX=enforcing

- name: Make sure group wheel is not in the sudoers configuration
  lineinfile:
    path: /etc/sudoers
    state: absent
    regexp: '^%wheel'

- name: Replace a localhost entry with our own
  lineinfile:
    path: /etc/hosts
    regexp: '^127\.0\.0\.1'
    line: 127.0.0.1 localhost
    owner: root
    group: root
    mode: '0644'

- name: Ensure the default Apache port is 8080
  lineinfile:
    path: /etc/httpd/conf/httpd.conf
    regexp: '^Listen '
    insertafter: '^#Listen '
    line: Listen 8080

- name: Ensure we have our own comment added to /etc/services
  lineinfile:
    path: /etc/services
    regexp: '^# port for http'
    insertbefore: '^www.*80/tcp'
    line: '# port for http by default'

- name: Add a line to a file if the file does not exist, without passing regexp
  lineinfile:
    path: /tmp/testfile
    line: 192.168.1.99 foo.lab.net foo
    create: yes

# NOTE: Yaml requires escaping backslashes in double quotes but not in single quotes
- name: Ensure the JBoss memory settings are exactly as needed
  lineinfile:
    path: /opt/jboss-as/bin/standalone.conf
    regexp: '^(.*)Xms(\\d+)m(.*)$'
    line: '\1Xms${xms}m\3'
    backrefs: yes

# NOTE: Fully quoted because of the ': ' on the line. See the Gotchas in the YAML docs.
- name: Validate the sudoers file before saving
  lineinfile:
    path: /etc/sudoers
    state: present
    regexp: '^%ADMIN ALL='
    line: '%ADMIN ALL=(ALL) NOPASSWD: ALL'
    validate: /usr/sbin/visudo -cf %s
```

## debug, Print statements during execution

```
# Example that prints the loopback address and gateway for each host
- debug:
    msg: System {{ inventory_hostname }} has uuid {{ ansible_product_uuid }}

- debug:
    msg: System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}
  when: ansible_default_ipv4.gateway is defined

# Example that prints return information from the previous task
- shell: /usr/bin/uptime
  register: result

- debug:
    var: result
    verbosity: 2

- name: Display all variables/facts known for a host
  debug:
    var: hostvars[inventory_hostname]
    verbosity: 4

# Example that prints two lines of messages, but only if there is an environment value set
- debug:
    msg:
    - "Provisioning based on YOUR_KEY which is: {{ lookup('env', 'YOUR_KEY') }}"
    - "These servers were built using the password of '{{ password_used }}'. Please retain this for later use."
```
