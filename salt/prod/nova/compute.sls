openstack-nova:
  pkg.installed:
    - require:
      - pkg: openstack_repo
    - names:
      - openstack-nova-compute
  service.running:
    - enable: True
    - names:
      - openstack-nova-compute
    - watch:
      - file: /etc/nova/nova.conf
      - pkg: openstack-nova-compute

nova.conf:
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova/nova-compute.conf
    - template: jinja
