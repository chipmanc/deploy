neutron_rabbit:
  rabbitmq_user.present:
    - name: neutron
    - password: {{ pillar['neutron_rabbit_password'] }}
    - require:
      - service: rabbitmq-server
  rabbitmq_vhost.present:
    - name: neutron
    - owner: neutron
    - require: 
      - service: rabbitmq-server
