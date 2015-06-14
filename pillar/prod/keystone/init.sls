include:
  - keystone.nova_auth:
      key: users
  - keystone.glance_auth:
      key: users
  - keystone.neutron_auth:
      key: users
  - keystone.cinder_auth:
      key: users

mine_functions:
  network.ip_addrs: {}
  mnet_ip_addrs:
    mine_function: network.ip_addrs
    cidr: 192.168.10.0/24
  pnet_ip_addrs:
    mine_function: network.ip_addrs
    cidr: 10.0.0.0/16

keystone.token: paeGh9ch
keystone.endpoint: http://intra-keystone.chrischipman.com:35357/v2.0

keystone_admin_pass: sld9S89Lvbw

services:
  nova: compute
  cinder: volume
  cinderv2: volumev2
  neutron: network
  glance: image
  keystone: identity

endpoints:
  keystone:
    port: 5000
    admin_port: 35357
  glance:
    port: 9292
    admin_port: 9292
  nova:
    port: 8774
    admin_port: 8774
