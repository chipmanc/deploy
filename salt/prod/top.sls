prod:
  '*':
    - common
    - openstack

  'role:keystone':
    - match: grain
    - keystone

  'role:keystone-db':
    - match: grain
    - database
    - keystone-db

  'role:glance':
    - match: grain
    - glance
