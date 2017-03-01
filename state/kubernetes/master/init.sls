include:
  - kubernetes.master.pkg
  - kubernetes.master.services
  - kubernetes.master.files

cmds:
  cmd.run:
    - name: |
        etcdctl mk /atomic.io/network/config '{"Network":"172.17.0.0/16"}'
    - require:
      - service: etcd
    - unless: etcdctl ls atomic.io/network
