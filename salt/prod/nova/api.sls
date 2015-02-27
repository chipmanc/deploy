openstack-nova:
  pkg.installed:
    - require:
      - pkg: openstack_repo
    - names:
      - openstack-nova-api
      - openstack-nova-cert
      - openstack-nova-conductor
      - openstack-nova-console
      - openstack-nova-novncproxy
      - openstack-nova-scheduler
      - python-novaclient
  service.running:
    - enable: True
    - names:
      - openstack-nova-api
      - openstack-nova-cert
      - openstack-nova-conductor
      - openstack-nova-consoleauth
      - openstack-nova-novncproxy
      - openstack-nova-scheduler
    - watch:
      - file: /etc/nova/nova.conf
      - pkg: openstack-nova-api
      - pkg: openstack-nova-cert
      - pkg: openstack-nova-conductor
      - pkg: openstack-nova-console
      - pkg: openstack-nova-novncproxy
      - pkg: openstack-nova-scheduler

nova.conf:
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova/nova-api.conf
    - template: jinja
