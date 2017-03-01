{% for port in pillar['internal_ports'] %}
{{ port }}:
  iptables.insert:
    - position: 1
    - table: filter
    - chain: INPUT
    - proto: tcp
    - dport: {{ port }}
    - i: eth1
    - save: True
    - jump: ACCEPT
{% endfor %}


{% for port in pillar['external_ports'] %}
{{ port }}:
  iptables.insert:
    - position: 1
    - table: filter
    - chain: INPUT
    - proto: tcp
    - dport: {{ port }}
    - save: True
    - jump: ACCEPT
{% endfor %}
 
loopback:
  iptables.insert:
    - position: 1
    - table: filter
    - chain: INPUT
    - i: lo
    - jump: ACCEPT
    - save: True

related:
  iptables.insert:
    - position: 1
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: RELATED,ESTABLISHED
    - save: True
    - jump: ACCEPT

default:
  iptables.set_policy:
    - table: filter
    - chain: INPUT
    - policy: DROP
