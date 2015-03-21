neutron:
  mysql_database:
    - present
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_user.present:
    - name: neutron
    - password: {{ pillar['neutron_db_pass'] }}
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
  mysql_grants.present:
    - grant: all privileges
    - database: neutron.*
    - user: neutron
    - host: '%'
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}


