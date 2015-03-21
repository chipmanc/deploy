include:
  - rabbit
  - keystone.nova_auth:
      key: users
  - keystone.glance_auth:
      key: users
  - keystone.neutron_auth:
      key: users
  - keystone.cinder_auth:
      key: users
  - keystone.nova_endpoint:
      key: endpoints
  - keystone.glance_endpoint:
      key: endpoints
  - keystone.neutron_endpoint:
      key: endpoints
  - keystone.cinder_endpoint:
      key: endpoints
  - keystone.keystone_endpoint:
      key: endpoints

keystone.token: iP9uG8ScHpA9sG3
keystone.endpoint: http://{{ salt['grains.get']('ip4_interfaces:eth0')[0] }}:35357/v2.0

admin.pass: sld9S89Lvbw

services:
  nova: compute
  cinder: volume
  cinderv2: volumev2
  neutron: network
  glance: image
  keystone: identity

