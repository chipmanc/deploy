include:
  - common.mariadb
glance:
  mysql_database:
    - present
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_user.present:
    - name: glance
    - password: {{ pillar['glance_db_pass'] }}
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_grants.present:
    - grant: all privileges
    - database: glance.*
    - user: glance
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}


