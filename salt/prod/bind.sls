openstack:
  ddns.present:
    - zone: chrischipman.com
    - ttl: 300
    - name: intra-keystone
    - data: 192.168.10.134
