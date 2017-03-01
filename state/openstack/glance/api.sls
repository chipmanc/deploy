api-setup:
  service.running:
    - enable: True
    - name: openstack-glance-api
    - watch:
      - file: /etc/glance/glance-api.conf
      - pkg: openstack-glance
  file.managed:
    - name: /etc/glance/glance-api.conf
    - source: salt://glance/glance-api.conf
    - template: jinja

