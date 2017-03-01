nova-api:
  pkg.installed:
    - names:
      - openstack-nova-api
      - python-novaclient
  service.running:
    - enable: True
    - name: openstack-nova-api
    - watch:
      - file: /etc/nova/nova.conf
      - pkg: openstack-nova-api
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova/nova.conf
    - template: jinja
    - require:
      - pkg: openstack-nova-api
  cmd.run:
    - name: su -s /bin/sh -c "nova-manage db sync" nova
    - onchanges:
      - pkg: openstack-nova-api
    - require:
      - file: /etc/nova/nova.conf

