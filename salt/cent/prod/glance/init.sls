glance:
  pkg.installed:
    - names:
      - openstack-glance
      - python-glanceclient
    - require:
      - pkg: openstack
