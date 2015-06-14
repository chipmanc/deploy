base:
  'G@roles:*db':
    - common.mariadb
    - database.iptables

  'G@roles:*rabbit':
    - rabbit
    - rabbit.iptables

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
    - keystone.setup
    - keystone.iptables

  'roles:glance-api':
    - match: grain
    - glance
    - glance.api
    - glance.iptables

  'roles:glance-registry':
    - match: grain
    - glance
    - glance.registry
    - glance.iptables

  'roles:nova-api':
    - match: grain
    - nova.api

  'roles:nova-conductor':
    - match: grain
    - nova.conductor

  'roles:nova-compute':
    - match: grain
    - nova.compute

  'roles:nova-scheduler':
    - match: grain
    - nova.scheduler

  '*':
    - metrics.client
    - base.pkg

  'roles:metrics':
    - match: grain
    - metrics.server
