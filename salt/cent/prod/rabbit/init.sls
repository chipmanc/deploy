rabbitmq-server:
  pkg.installed: 
    - require:
      - pkg: openstack-selinux
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: rabbitmq-server
    - require_in:
      - cinder_rabbit 
      - nova_rabbit
