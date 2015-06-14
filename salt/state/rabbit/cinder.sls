cinder_rabbit:
  rabbitmq_user.present:
    - name: cinder
    - password: {{ pillar['cinder_rabbit_password'] }}
  rabbitmq_vhost.present:
    - name: cinder
    - owner: cinder

