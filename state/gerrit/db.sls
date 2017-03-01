mariadb:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - MySQL-python
  service.running:
    - enable: True
  cmd.wait:
    - name: mysqladmin --user root password {{ pillar['root_db_pass'] }};
    - watch:
      - pkg: mariadb
  file.managed:
    - source: salt://gerrit/files/my.cnf
    - user: root
    - name: /root/.my.cnf

salt_db:
  cmd.run:
    - name: mysqladmin --user root -p{{ pillar['root_db_pass'] }} create salt
    - creates: /var/lib/mysql/salt

gerrit_db:
  mysql_database.present:
    - name: gerrit
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
    - connection_host: localhost

gerrit_db_user:
  mysql_query.run:
    - query: GRANT ALL on gerrit.* to gerrit@localhost IDENTIFIED by "{{ pillar['gerrit_db_pass'] }}"; FLUSH PRIVILEGES;
    - connection_user: root
    - connection_pass: {{ pillar['root_db_pass'] }}
    - connection_host: localhost
    - name: gerrit
    - database: gerrit
