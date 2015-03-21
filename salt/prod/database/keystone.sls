keystone:
  mysql_database:
    - present
    - connection_user: root
    - connection_pass: {{ pillar['connection_pass'] }}
  mysql_user.present:
    - name: keystone
    - password: {{ pillar['keystone_db_pass'] }}
    - connection_user: root
    - connection_pass: {{ pillar['connection_pass'] }}
  mysql_grants.present:
    - grant: all privileges
    - database: keystone.*
    - user: keystone
    - connection_user: root
    - connection_pass: {{ pillar['connection_pass'] }}

keystone_db_sync:
  cmd.run:
    - name: su -s /bin/sh -c 'keystone-manage db_sync' keystone
