include:
  - mysql_cluster.data.pkg
  - mysql_cluster.data.files

ndbd:
  cmd.run:
    - name: ndbd
    - unless: ps aux | grep [n]dbd
