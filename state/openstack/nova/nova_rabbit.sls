include:
  - common.rabbitmq

nova_rabbit:
  rabbitmq_user.present:
    - name: nova
    - password: {{ pillar['nova_rabbit_password'] }}
    - require:
      - service: rabbitmq_server
  rabbitmq_vhost.present:
    - name: nova
    - owner: nova
    - require:
      - service: rabbitmq-server
