prod:
  '*':
    - common
    - openstack

  'role:glance-db':
    - match: grain
    - database
    - database.glance

  'role:glance':
    - match: grain
    - glance

  'role:keystone-db':
    - match: grain
    - database
    - database.keystone

  'role:keystone':
    - match: grain
    - keystone

  'role:nova-db':
    - match: grain
    - database.nova

  'role:nova-api':
    - match: grain
    - nova.api
