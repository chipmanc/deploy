include:
  - ldap.pkg
  - ldap.initialize
  - base.iptables

{% set password = pillar['root_dn_password'] %}
{% set base_dn = pillar['basedn']['name'] %}

ldapi:///:
  ldap.managed:
    - require: [slapd]
    - connect_spec:
        bind:
          method: simple
          dn: cn=root,dc=chrischipman,dc=com
          password: {{ password }}
    - entries:
      - {{ base_dn }}:
        - default:
            objectClass: {{ pillar['basedn']['objectClass'] }}
            dc: chrischipman
            o: Chris Chipman
      - ou=Groups,{{ base_dn }}:
        - default:
            objectClass:
              - organizationalUnit
            ou: Groups            
      - ou=Users,{{ base_dn }}:
        - default:
            objectClass:
              - organizationalUnit
            ou: Users            

      {% for group_name, data in pillar['groups'].iteritems() %}
      {% set members = data['members'] %}
      {% set data = data['data'] %}
      - cn={{ group_name }},ou=Groups,{{ base_dn }}:
        - default:
            {{ data }}
      {% for member in members %}
        - add:
            memberUid: {{ member }}
      {% endfor %}
      {% endfor %}

      {% for username, data in pillar['accounts'].iteritems() %}
      - uid={{ username }},ou=Users,{{ base_dn }}:
        - replace:
            {{ data }}
      {% endfor %}
