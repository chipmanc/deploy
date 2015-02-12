openstack-keystone:
  pkg.installed:
    - require:
      - pkg: openstack_repo
  service.running:
    - enable: True
    - watch:
      - file: /etc/keystone/keystone.conf
      - pkg: openstack-keystone
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
    - onchanges:
      - pkg: openstack-keystone

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

admin:
  keystone.user_present:
    - email: admin@company.com
    - password: {{ pillar['admin.pass'] }}
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

{% for endpoint, data in pillar['endpoints'].iteritems() %}
{{ endpoint }}_endpoint:
  keystone.endpoint_present:
    - name: {{ endpoint }}
    - publicurl: {{ data['publicurl'] }}
    - internalurl: {{ data['internalurl'] }}
    - adminurl: {{ data['adminurl'] }}
    - region: {{ data['region'] }}
{% endfor %}




