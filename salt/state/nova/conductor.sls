nova-conductor:
  pkg.installed:
    - names:
      - openstack-nova-conductor
      - python-cinderclient
  service.running:
    - enable: True
    - name: openstack-nova-conductor
    - watch:
      - file: /etc/nova/nova.conf
      - pkg: openstack-nova-conductor
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://nova/nova.conf
    - template: jinja
    - require:
      - pkg: openstack-nova-conductor

