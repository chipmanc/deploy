openstack_repo:
  pkg.installed:
    - sources:
      - rdo-release: http://rdo.fedorapeople.org/openstack-juno/rdo-release-juno.rpm

openstack-selinux:
  pkg.installed:
    - require:
      - pkg: common_packages
