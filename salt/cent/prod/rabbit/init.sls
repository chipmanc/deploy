rabbitmq-server:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: rabbitmq-server
    - require_in:
      - cinder_rabbit 
      - nova_rabbit
      - neutron_rabbit
