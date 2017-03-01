rabbitmq:
  pkg.installed:
    - name: rabbitmq-server
  service.running:
    - name: rabbitmq-server
    - enable: True
    - reload: True
    - watch:
      - pkg: rabbitmq-server
