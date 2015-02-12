include:
  - common
    users:
      nova: lkSD90bzpT09VDa
    public_net:
      nova: {{ salt['grains.get']('ip4_interfaces:eth0')[0] }}
    admin_net:
      nova: {{ salt['grains.get']('ip4_interfaces:eth0')[0] }}
    internal_net:
      nova: {{ salt['grains.get']('ip4_interfaces:eth0')[0] }}
