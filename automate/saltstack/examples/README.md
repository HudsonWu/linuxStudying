# salt配置示例

## master配置

### `file_roots`和`pillar_roots`

```
# /etc/salt/master.d/file_roots.conf
file_roots:
  base:
    - /srv/salt/base
  production:
    - /srv/salt/production
  staging:
    - /srv/salt/staging
  development:
    - /srv/salt/development

# /etc/salt/master.d/pillar_roots.conf
pillar_roots:
  base:
    - /srv/salt/pillar/base
  production:
    - /srv/salt/pillar/production
  staging:
    - /srv/salt/pillar/staging
  development:
    - /srv/salt/pillar/development
```
