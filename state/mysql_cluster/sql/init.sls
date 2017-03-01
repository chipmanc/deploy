{% set django_password = pillar['django_user_password'] %}
{% set password = pillar['root_db_pass'] %}
include:
  - mysql_cluster.sql.pkg
  - mysql_cluster.sql.files

mysqld:
  service.running:
    - enable: True

reset_password:
  cmd.run:
    - env:
      - PASS: {{ password }}
      - DJANGO_PASS: {{ django_password }}
    - name: |
        export TEMP_PASS=`grep -m1 'A temporary password.*root@localhost' /var/log/messages  |awk '{print $NF}'`;
        mysql --connect-expired-password -e "set password = password(\"$PASS\")" -p$TEMP_PASS;
        sed -i "s@XXXX@$PASS@" /root/.my.cnf
    - require:
      - file: root_my.cnf
    - onlyif:
      - grep 'XXXX' /root/.my.cnf

django_setup:
  cmd.run:
    - env:
      - PASS: {{ password }}
      - DJANGO_PASS: {{ django_password }}
    - name: |
        mysql -p$PASS -e 'create database django_malware';
        mysql -p$PASS -e 'grant all on django_malware.* to django_user identified by '"\"$DJANGO_PASS\"";

ndb_engine:
  cmd.run:
    - env:
      - PASS: {{ password }}
    - name: mysql -p$PASS -e 'set default_storage_engine=ndb'
