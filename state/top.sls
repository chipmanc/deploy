base:
  '*':
    - metrics.client
    - base

  'G@roles:kube-master':
    - kubernetes.master

  'G@roles:kube-slave':
    - kubernetes.slave

  'G@roles:*db':
    - common.mariadb

  'G@roles:*rabbit':
    - common.rabbitmq

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

  'roles:metrics':
    - match: grain
    - metrics.server

  'django*':
    - finance

  'jenkins*':
    - jenkins

  'ldap*':
    - ldap

  'dev1*':
    - ldap

  'gerrit*':
    - gerrit

  'roles:webapp':
    - match: grain
    - challenge.webapp

  'roles:database':
    - match: grain
    - challenge.db

  'roles:proxy':
    - match: grain
    - challenge.proxy

  'roles:db-mgmt':
    - match: grain
    - mysql_cluster.mgmt

  'roles:db-data':
    - match: grain
    - mysql_cluster.data

  'roles:db-sql':
    - match: grain
    - mysql_cluster.sql
