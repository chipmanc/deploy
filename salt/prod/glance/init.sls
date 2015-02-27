openstack-glance:
  pkg.installed:
    - require:
      - pkg: openstack_repo
  service.running:
    - enable: True
    - names:
      - openstack-glance-api
      - openstack-glance-registry
    - watch:
      - file: /etc/glance/glance-api.conf
      - file: /etc/glance/glance-registry.conf
      - pkg: openstack-glance

api.conf:
  file.managed:
    - name: /etc/glance/glance-api.conf
    - source: salt://glance/glance-api.conf
    - template: jinja

registry.conf:
  file.managed:
    - name: /etc/glance/glance-registry.conf
    - source: salt://glance/glance-registry.conf
    - template: jinja
