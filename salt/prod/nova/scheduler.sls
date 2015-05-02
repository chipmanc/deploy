nova-scheduler:
  pkg.installed:
    - names:
      - openstack-nova-scheduler
  service.running:
    - enable: True
    - name: openstack-nova-scheduler
    - watch:
      - file: /etc/nova/nova.conf
      - pkg: openstack-nova-scheduler
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova/nova.conf
    - template: jinja
    - require:
      - pkg: openstack-nova-scheduler

