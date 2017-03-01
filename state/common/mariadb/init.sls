mariadb:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - MySQL-python
  service.running:
    - enable: True
    - require:
      - pkg: mariadb
  mysql_user.present:
    - name: root
    - host: localhost
    - password: {{ pillar['root_db_pass'] }}
    - require:
      - service: mariadb

empty_user:
  mysql_user.absent:
    - name: ''
    - host: localhost
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}


test:
  mysql_database.absent:
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
