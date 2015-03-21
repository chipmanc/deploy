mariadb-server:
  pkg:
    - installed
    - pkgs:
      - mariadb-server
      - MySQL-python
  service.running:
    - enable: True
    - reload: True
    - name: mariadb
  mysql_user:
    - present
    - name: root
    - password: BU11shit**
    - require:
      - service: mariadb
