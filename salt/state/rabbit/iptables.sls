include:
  - base.iptables

rabbit:
  iptables.insert:
    - position: 4
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - dport: 5672
    - proto: tcp
    - save: True
