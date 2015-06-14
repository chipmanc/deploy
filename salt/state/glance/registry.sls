registry-setup:
  service.running:
    - enable: True
    - name: openstack-glance-registry
    - watch:
      - file: /etc/glance/glance-registry.conf
      - pkg: openstack-glance
      - cmd: registry-setup
  file.managed:
    - name: /etc/glance/glance-registry.conf
    - source: salt://glance/glance-registry.conf
    - template: jinja
  cmd.run:
    - name: su -s /bin/sh -c "glance-manage db_sync" glance
    - require:
      - file: /etc/glance/glance-registry.conf
    - onchanges:
      - pkg: openstack-glance

