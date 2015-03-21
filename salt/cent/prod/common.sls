common-packages:
  pkg.installed:
    - names:
      - epel-release
      - vim-enhanced
      - net-tools
      - tcpdump
      - yum-plugin-priorities
      - mariadb

openstack:
  pkg.installed:
    - sources:
      - rdo-release: http://rdo.fedorapeople.org/openstack-juno/rdo-release-juno.rpm
    - require:
      - pkg: common-packages

openstack-selinux:
  pkg.installed:
    - require:
      - pkg: openstack

update:
  pkg.uptodate


