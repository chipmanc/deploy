include:
  - common.mariadb
nova:
  mysql_database:
    - present
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_user.present:
    - name: nova
    - password: {{ pillar['nova_db_pass'] }}
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_grants.present:
    - grant: all privileges
    - database: nova.*
    - user: nova
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}


