include:
  - ldap.iptables

root_dn_password: "ro27QXot--"

basedn:
  name: dc=chrischipman,dc=com
  objectClass:
    - dcObject
    - organization 

accounts:
  chrichip:
    uid: chrichip
    cn: Chris
    objectClass: [inetOrgPerson, posixAccount, shadowAccount]
    loginShell: /bin/bash
    homeDirectory: /home/chrichip
    userPassword: "ro27QXot--"
    uidNumber: 1001
    gidNumber: 1001
    sn: Chipman
  gerrit_admin:
    uid: gerrit_admin
    cn: Gerrit Admin
    objectClass: [inetOrgPerson, posixAccount]
    loginShell: /bin/bash
    homeDirectory: /srv/gerrit/gerrit
    userPassword: "ro27QXot--"
    uidNumber: 1002
    gidNumber: 1002
    sn: admin
  jenkins_admin:
    uid: jenkins_admin
    cn: Jenkins Admin
    objectClass: [inetOrgPerson, posixAccount]
    loginShell: /bin/bash
    homeDirectory: /var/lib/jenkins
    userPassword: "ro27QXot--"
    uidNumber: 1003
    gidNumber: 1003
    sn: admin


groups:
  chrichip:
    members:
      - chrichip
    data:
      objectClass: posixGroup
      cn: chrichip
      memberUid: chrichip
      gidNumber: 1001
  gerrit_admins:
    members:
      - chrichip
      - gerrit_admin
    data:
      objectClass: posixGroup
      cn: Admin
      gidNumber: 1002
      memberUid: gerrit_admin
  git_devs:
    members:
      - chrichip
    data:
      objectClass: posixGroup
      cn: git_devs
      gidNumber: 1003
  jenkins_admins:
    members:
      - chrichip
      - jenkins_admin
    data:
      objectClass: posixGroup
      cn: Admin
      gidNumber: 1003
      memberUid: jenkins_admin

