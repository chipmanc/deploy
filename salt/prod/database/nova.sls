include:
  - nova

nova:
  mysql_database:
    - present
    - connection_user: {{ pillar['connection_user'] }}
    - connection_pass: {{ pillar['connection_pass'] }}
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_db_pass'] }}
    - connection_user: {{ pillar['connection_user'] }}
    - connection_pass: {{ pillar['connection_pass'] }}
  mysql_grants.present:
    - grant: all privileges
    - database: nova.*
    - user: nova
    - connection_user: {{ pillar['connection_user'] }}
    - connection_pass: {{ pillar['connection_pass'] }}

nova_db_sync:
  cmd.run:
    - name: su -s /bin/sh -c 'nova-manage db sync' nova
    - require:
      - file: nova.conf

