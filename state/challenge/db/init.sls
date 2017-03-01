include:
  - common.mariadb

django_malware:
  mysql_database.present:
    - connection_pass: {{ pillar['root_db_pass'] }}

django_user:
  mysql_user.present:
    - host: '%'
    - password: {{ pillar['django_user_password'] }}
    - connection_pass: {{ pillar['root_db_pass'] }}

django_malware_grant:
  mysql_grants.present:
    - grant: all privileges
    - database: 'django_malware.*'
    - user: django_user
    - host: '%'
    - connection_pass: {{ pillar['root_db_pass'] }}
