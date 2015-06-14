nova_rabbit:
  rabbitmq_user.present:
    - name: nova
    - password: {{ pillar['nova_rabbit_password'] }}
  rabbitmq_vhost.present:
    - name: nova
    - owner: nova


