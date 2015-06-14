keystone:
  pkg.installed:
    - names:
      - openstack-selinux
      - openstack-keystone
      - python-keystoneclient
  service.running:
    - enable: True
    - name: openstack-keystone
    - watch:
      - file: /etc/keystone/keystone.conf
      - pkg: openstack-keystone
      - cmd: keystone
  file.managed:
    - name: /etc/keystone/keystone.conf
    - source: salt://keystone/keystone.conf
    - template: jinja
  cmd.run:
    - name: |
        keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
        chown -R keystone:keystone /var/log/keystone
        chown -R keystone:keystone /var/log/keystone
        chown -R keystone:keystone /etc/keystone/ssl
        chmod -R o-rwx /etc/keystone/ssl
        su -s /bin/sh -c 'keystone-manage db_sync' keystone
    - onchanges:
      - pkg: openstack-keystone
    - require:
      - file: /etc/keystone/keystone.conf

