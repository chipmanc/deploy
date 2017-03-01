slapd:
  pkg.installed:
    - pkgs:
      - openldap-servers
      - python-ldap
  service.running:
    - enable: True

