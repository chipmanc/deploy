nova-compute:
  pkg.installed:
    - names:
      - openstack-nova-compute
    - require:
      - pkg: openstack
  service.running:
    - enable: True
    - name: openstack-nova-compute
    - watch:
      - file: /etc/nova/nova.conf
      - pkg: openstack-nova-compute
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova/nova.conf
    - template: jinja
    - require:
      - pkg: openstack-nova-compute

sysfsutils:
  pkg.installed: []

libvirtd:
  service.running: []
