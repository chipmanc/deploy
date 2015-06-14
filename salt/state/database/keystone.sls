include:
  - common.mariadb
keystone:
  mysql_database:
    - present
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_user.present:
    - name: keystone
    - password: {{ pillar['keystone_db_pass'] }}
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_grants.present:
    - grant: all privileges
    - database: 'keystone.*'
    - user: keystone
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}


