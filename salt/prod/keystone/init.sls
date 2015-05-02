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


tenants:
  keystone.tenant_present:
    - names:
      - admin
      - service
      - test

roles:
  keystone.role_present:
    - names:
      - admin

# Admin user gets created seperately because he needs to be admin 
# of the admin tenant as well.
admin:
  keystone.user_present:
    - email: admin@company.com
    - password: {{ pillar['keystone_admin_pass'] }}
    - roles:
      - admin:
        - admin
      - service:
        - admin

{% for user, pass in pillar.get('users', {}).items() %}
{{ user }}_user:
  keystone.user_present:
    - name: {{ user }}
    - email: {{ user }}@company.com
    - password: {{ pass }}
    - roles:
      - service:
        - admin
{% endfor %}

{% for service, type in pillar.get('services', {}).items() %}
{{ service }}_service:
  keystone.service_present:
    - name: {{ service }}
    - service_type: {{ type }}
{% endfor %}

# Getting IP addresses from Salt Mine.  Should change to DNS records if behind LB
keystone_endpoint_present:
  keystone.endpoint_present:
    - name: keystone
    - publicurl: http://{{ salt['mine.get']('roles:keystone', 'pnet_ip_addrs', expr_form='grain')['keystone'][0] }}:5000/v2.0
    - internalurl: http://{{ salt['mine.get']('roles:keystone', 'mnet_ip_addrs', expr_form='grain')['keystone'][0] }}:5000/v2.0
    - adminurl: http://{{ salt['mine.get']('roles:keystone', 'mnet_ip_addrs', expr_form='grain')['keystone'][0] }}:35357/v2.0
    - region: GVL

glance_endpoint_present:
  keystone.endpoint_present:
    - name: glance
    - publicurl: http://{{ salt['mine.get']('roles:glance-api', 'pnet_ip_addrs', expr_form='grain')['glance'][0] }}:9292
    - internalurl: http://{{ salt['mine.get']('roles:glance-api', 'mnet_ip_addrs', expr_form='grain')['glance'][0] }}:9292
    - adminurl: http://{{ salt['mine.get']('roles:glance-api', 'mnet_ip_addrs', expr_form='grain')['glance'][0] }}:9292
    - region: GVL

nova_endpoint_present:
  keystone.endpoint_present:
    - name: nova
    - publicurl: http://nova-api.gvl.chrischipman.com:8774/v2/%(tenant_id)s
    - internalurl: http://{{ salt['mine.get']('roles:nova-api', 'mnet_ip_addrs', expr_form='grain')['nova-api.ManagementNet'][0] }}:8774/v2/%(tenant_id)s
    - adminurl: http://{{ salt['mine.get']('roles:nova-api', 'mnet_ip_addrs', expr_form='grain')['nova-api.ManagementNet'][0] }}:8774/v2/%(tenant_id)s
    - region: GVL



