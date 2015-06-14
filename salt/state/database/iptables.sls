include:
  - base.iptables

mysql:
  iptables.insert:
    - position: 4
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - dport: 3306
    - proto: tcp
    - save: True
