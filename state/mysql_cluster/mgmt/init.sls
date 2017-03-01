include:
  - mysql_cluster.mgmt.pkg
  - mysql_cluster.mgmt.files

ndb_mgmd:
  cmd.run:
    - name: ndb_mgmd -f /var/lib/mysql-cluster/config.ini
    - unless: ls /var/lib/mysql-cluster/ndb*.pid
