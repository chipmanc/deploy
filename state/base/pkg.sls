salt:
  pkg.installed:
    - sources:
      - salt-repo: https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm 

common_packages:
  pkg.installed:
    - pkgs:
      - sssd-ldap
      - python-sssdconfig
      - vim-enhanced

uninstall:
  pkg.removed:
    - pkgs:
      - firewalld

update:
  pkg.uptodate
