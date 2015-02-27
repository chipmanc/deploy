include:
  - glance

glance:
  mysql_database:
    - present
    - connection_user: {{ pillar['connection_user'] }}
    - connection_pass: {{ pillar['connection_pass'] }}
  mysql_user.present:
    - name: glance
    - password: {{ pillar['glance_db_pass'] }}
    - connection_user: {{ pillar['connection_user'] }}
    - connection_pass: {{ pillar['connection_pass'] }}
  mysql_grants.present:
    - grant: all privileges
    - database: glance.*
    - user: glance
    - connection_user: {{ pillar['connection_user'] }}
    - connection_pass: {{ pillar['connection_pass'] }}

glance_db_sync:
  cmd.run:
    - name: su -s /bin/sh -c 'glance-manage db_sync' glance
    - require:
      - file: registry.conf
