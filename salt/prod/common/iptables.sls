firewalld:
  service.dead:
    - name: firewalld
    - enable: False

localhost:
  iptables.insert:
    - table: filter
    - chain: INPUT
    - position: 1
    - in-interface: lo
    - jump: ACCEPT
    - save: True

connstate:
  iptables.insert:
    - table: filter
    - chain: INPUT
    - position: 2
    - connstate: RELATED,ESTABLISHED
    - jump: ACCEPT
    - save: True

ssh:
  iptables.insert:
    - table: filter
    - chain: INPUT
    - position: 3
    - proto: tcp
    - dport: 22
    - jump: ACCEPT
    - save: True

drop:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: REJECT
    - save: True

