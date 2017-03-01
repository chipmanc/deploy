db-mgmt:
  salt.state:
    - tgt: 'roles:db-mgmt'
    - tgt_type: grain
    - highstate: True

db-data:
  salt.state:
    - tgt: 'roles:db-data'
    - tgt_type: grain
    - highstate: True
    - require:
      - salt: db-mgmt

db-sql:
  salt.state:
    - tgt: 'roles:db-sql'
    - tgt_type: grain
    - highstate: True
    - require:
      - salt: db-data

proxy:
  salt.state:
    - tgt: 'roles:proxy'
    - tgt_type: grain
    - highstate: True
    - require:
      - salt: db-sql

webapp:
  salt.state:
    - tgt: 'roles:webapp'
    - tgt_type: grain
    - highstate: True
    - require:
      - salt: proxy

