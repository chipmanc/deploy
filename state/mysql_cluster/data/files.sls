my.cnf:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://mysql_cluster/files/my.cnf
    - template: jinja

data_dir:
  file.directory:
    - name: /usr/local/mysql/data/
    - makedirs: True
