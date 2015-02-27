openstack-neutron:
  pkg.installed:
    - require:
      - pkg: openstack_repo
    - names:
      - openstack-neutron
      - openstack-neutron-ml2
      - python-neutronclient
      - which
  service.running:
    - enable: True
    - names:
      - neutron-server
    - watch:

neutron.conf:
  file.managed:
    - name: /etc/neutron/neutron.conf
    - source: salt://neutron/neutron.conf
    - template: jinja

