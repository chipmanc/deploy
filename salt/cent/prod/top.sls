cent-prod:
  '*':
    - common

  '*db':
    - database

  '*rabbit':
    - rabbit

  'roles:nova-rabbit':
    - match: grain
    - rabbit.nova

  'roles:neutron-rabbit':
    - match: grain
    - rabbit.neutron

  'roles:cinder-rabbit':
    - match: grain
    - rabbit.cinder

  'roles:nova-db':
    - match: grain
    - database.nova

  'roles:keystone-db':
    - match: grain
    - database.keystone

  'roles:glance-db':
    - match: grain
    - database.glance

  'roles:neutron-db':
    - match: grain
    - database.neutron

  'roles:cinder-db':
    - match: grain
    - database.cinder

  'roles:keystone':
    - match: grain
    - keystone

  'roles:glance-api':
    - match: grain
    - glance
    - glance.api

  'roles:glance-registry':
    - match: grain
    - glance
    - glance.registry

  'roles:nova-api':
    - match: grain
    - nova.api

  'roles:nova-compute':
    - match: grain
    - nova.compute
