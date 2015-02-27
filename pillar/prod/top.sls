prod:
  'role:keystone':
    - match: grain
    - keystone

  'role:keystone-db':
    - match: grain
    - database
    - database.keystone

  'role:nova-api':
    - match: grain
    - nova
    - keystone.nova_auth
    - keystone.neutron_auth

  'role:nova-db':
    - match: grain
    - database
    - database.nova

  'role:glance':
    - match: grain
    - glance
    - keystone.glance_auth

  'role:glance-db':
    - match: grain
    - database
    - database.glance

  '*':
    - common
