nova-compute:
  pkg.installed:
    - names:
      - openstack-nova-compute
      - sysfsutils
  service.running:
    - enable: True
    - names:
      - openstack-nova-compute
      - libvirtd
    - watch:
      - file: /etc/nova/nova.conf
      - pkg: openstack-nova-compute
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova/nova.conf
    - template: jinja
    - require:
      - pkg: openstack-nova-compute

