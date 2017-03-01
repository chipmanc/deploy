database.chrischipman.com:
  salt.state:
    - tgt: 'roles:database'
    - tgt_type: grain
    - highstate: True

webapp.chrischipman.com:
  salt.state:
    - tgt: 'roles:webapp'
    - tgt_type: grain
    - highstate: True
    - require:
      - salt: database.chrischipman.com

proxy.chrischipman.com:
  salt.state:
    - tgt: 'roles:proxy'
    - tgt_type: grain
    - highstate: True
    - require:
      - salt: webapp.chrischipman.com
