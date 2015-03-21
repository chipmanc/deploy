cent-prod:

  'roles:nova-rabbit':
    - match: grain
    - rabbit
    - rabbit.nova

  'roles:neutron-rabbit':
    - match: grain
    - rabbit
    - rabbit.neutron

  'roles:cinder-rabbit':
    - match: grain
    - rabbit
    - rabbit.cinder

  'roles:nova-db':
    - match: grain
    - database
    - database.nova

  'roles:keystone-db':
    - match: grain
    - database
    - database.keystone

  'roles:glance-db':
    - match: grain
    - database
    - database.glance

  'roles:neutron-db':
    - match: grain
    - database
    - database.neutron

  'roles:cinder-db':
    - match: grain
    - database
    - database.cinder

  'roles:keystone':
    - match: grain
    - keystone
    - database.keystone

  'roles:glance-api':
    - match: grain
    - glance
    - keystone.glance_auth
    - database.glance

  'roles:glance-registry':
    - match: grain
    - glance
    - keystone.glance_auth
    - database.glance

  'P@roles:nova-.*':
    - nova
    - keystone.nova_auth
    - database.nova
    - rabbit.nova
