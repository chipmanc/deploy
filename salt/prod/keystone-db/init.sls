keystone:
  mysql_database:
    - present
    - connection_user: root
    - connection_pass: BU11shit**
  mysql_user.present:
    - name: {{ pillar['db_user'] }} 
    - password: {{ pillar['db_pass'] }}
    - connection_user: root
    - connection_pass: BU11shit**
#  mysql_grants.present:
#    - grant: all privileges
#    - database: {{ pillar['db_name'] }}.*
#    - user: {{ pillar['db_user'] }}
#    - connection_user: root
#    - connection_pass: BU11shit**

keystone_db_sync:
  cmd.run:
    - name: su -s /bin/sh -c 'keystone-manage db_sync' keystone
