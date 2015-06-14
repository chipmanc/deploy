include:
  - base.iptables

keystone_public:
  iptables.insert:
    - position: 4
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - dport: 5000
    - proto: tcp
    - save: True

keystone_admin:
  iptables.insert:
    - position: 5
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - dport: 35357
    - in-interface: eth0
    - proto: tcp
    - save: True

drop:
  iptables.insert:
    - position: 6
    - table: filter
    - chain: INPUT
    - jump: REJECT
    - save: True
