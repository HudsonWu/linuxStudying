# jinja

## 条件语句

```
{% if grains['os_family'] == 'RedHat' %}
apache: httpd
git: git
{% elif grains['os_family'] == 'Debian' %}
apache: apache2
git: git-core
{% endif %}
```

## 循环语句

```
{% for usr in ['moe', 'larry', 'curly'] %}
{{ usr }}:
  user.present
{% endfor %}

{% for DIR in ['/dir1', '/dir2', '/dir3'] %}
{{ DIR }}:
  file.directory:
    - user: root
    - group: root
    - mode: 774
{% endfor %}
```

## 调用salt获取数据

```
{{ salt.cmd.run('whoami') }}
```
