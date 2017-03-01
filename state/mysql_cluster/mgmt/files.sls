mysql_directory:
  file.directory:
    - name: /var/lib/mysql-cluster

config.ini:
  file.managed:
    - name: /var/lib/mysql-cluster/config.ini
    - source: salt://mysql_cluster/mgmt/files/config.ini
    - template: jinja
