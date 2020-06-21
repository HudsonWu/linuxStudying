generic_user:
  user.present:
    - name: {{ pillar['dev_user']['hudson']['name'] }}
    - shell: /bin/bash
    - home: /home/{{ pillar['dev_user']['hudson']['name'] }}
    - uid: {{ pillar['dev_user']['hudson']['uid'] }}
    - password: {{ pillar['dev_user']['hudson']['password'] }}

