include:
  - nova.common

db_user: keystone
db_pass: sdkl8KSDewnT26
db_ip: 127.0.0.1
db_name: keystone

keystone.token: iP9uG8ScHpA9sG3
keystone.endpoint: http://{{ salt['grains.get']('ip4_interfaces:eth0')[0] }}:35357/v2.0

keystone_public_api: &KPA http://{{ salt['grains.get']('ip4_interfaces:eth0')[0] }}:5000/v2.0
keystone_admin_api: &KAA http://{{ salt['grains.get']('ip4_interfaces:ens9')[0] }}:35357/v2.0
keystone_internal_api: &KIA http://{{ salt['grains.get']('ip4_interfaces:ens9')[0] }}:5000/v2.0

admin.pass: sld9S89Lvbw

users:
  cinder: s9d8D900ssomLS
  neutron: 53DG3s89skkw
  glance: 32l2nlSD2d3dd
  keystone: ds09nlDD5GM

services:
  nova: compute
  cinder: volume
  cinderv2: volumev2
  neutron: network
  glance: image
  keystone: identity

endpoints:
  nova:
    publicurl: asdf
    internalurl: http://nova_int_api:8774/v2/%(tenant_id)s 
    adminurl: http://nova_admin_api:8774/v2/%(tenant_id)s 
    region: regionOne
  cinder:
    publicurl: http://10.0.0.10:8776/v2/%(tenant_id)s
    internalurl: http://192.168.10.123:8776/v2/%(tenant_id)s
    adminurl: http://192.168.10.123:8776/v2/%(tenant_id)s
    region: regionOne
  cinderv2:
    publicurl: http://10.0.0.10:8776/v2/%(tenant_id)s
    internalurl: http://192.168.10.123:8776/v2/%(tenant_id)s
    adminurl: http://192.168.10.123:8776/v2/%(tenant_id)s
    region: regionOne
  neutron:
    publicurl: http://10.0.0.10:9696
    internalurl: http://192.168.10.123:9696
    adminurl: http://192.168.10.123:9696
    region: regionOne
  glance:
    publicurl: http://10.0.0.10:9292
    internalurl: http://192.168.10.123:9292
    adminurl: http://192.168.10.123:9292
    region: regionOne
  keystone:
    publicurl: *KPA
    internalurl: *KIA
    adminurl: *KAA
    region: regionOne
