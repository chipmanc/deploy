include:
  - base.pkg

sssd:
  cmd.run:
    - name: 'authconfig --enablesssd --enablesssdauth --enablelocauthorize --enableldap --enableldapauth --ldapserver=ldap://ldap.chrischipman.com:389 --disableldaptls --ldapbasedn=dc=chrischipman,dc=com --enablerfc2307bis --enablemkhomedir --update'
    - creates: /etc/sssd/sssd.conf
  service.running:
    - enable: True
