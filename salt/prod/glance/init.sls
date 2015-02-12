openstack-glance:
  pkg.installed:
    - require:
      -pkg: openstack_repo
