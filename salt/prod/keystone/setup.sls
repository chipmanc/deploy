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
        admin:
          - admin
        service:
          - admin

{% for user, pass in pillar.get('users', {}).items() %}
{{ user }}_user:
  keystone.user_present:
    - name: {{ user }}
    - email: {{ user }}@company.com
    - password: {{ pass }}
    - roles:
        service:
          - admin
{% endfor %}

{% for service, type in pillar.get('services', {}).items() %}
{{ service }}_service:
  keystone.service_present:
    - name: {{ service }}
    - service_type: {{ type }}
{% endfor %}

{% for service, ports in pillar.get('endpoints', {}).items() %}
{{ service }}_endpoint:
  keystone.endpoint_present:
    - name: {{ service }}
    - publicurl: http://{{ service }}.chrischipman.com:{{ ports['port'] }}/v2.0
    - internalurl: http://intra-{{ service }}.chrischipman.com:{{ ports['port'] }}/v2.0
    - adminurl: http://admin-{{ service }}.chrischipman.com:{{ ports['admin_port'] }}/v2.0
    - region: GVL
{% endfor %}
