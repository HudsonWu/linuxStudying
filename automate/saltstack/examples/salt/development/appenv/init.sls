appenv_file:
  file.managed:
    - name: /etc/environment
    - source: salt://appenv/files/environment
    - template: jinja
    - mode: 644
    - context:
      ipaddress: {{ grains['ip_interfaces']['eth0'][0] }}
      hostname: {{ grains['fqdn'] }}

