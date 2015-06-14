include:
  - common.mariadb
cinder:
  mysql_database:
    - present
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_user.present:
    - name: cinder
    - password: {{ pillar['cinder_db_pass'] }}
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_grants.present:
    - grant: all privileges
    - database: cinder.*
    - user: cinder
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}

