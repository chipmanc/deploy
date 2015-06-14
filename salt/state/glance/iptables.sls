include:
  - base.iptables

mysql:
  iptables.insert:
    - position: 4
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - dport: 9292
    - proto: tcp
    - save: True

drop:
  iptables.insert:
    - position: 5
    - table: filter
    - chain: INPUT
    - jump: REJECT
    - save: True
