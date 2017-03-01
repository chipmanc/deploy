my.cnf:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://mysql_cluster/files/my.cnf
    - template: jinja

root_my.cnf:
  file.managed:
    - name: /root/.my.cnf
    - source: salt://mysql_cluster/sql/files/root_my.cnf
    - unless:
      - ls /root/.my.cnf
