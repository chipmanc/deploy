include:
  - kubernetes.slave.pkg
  - kubernetes.slave.services
  - kubernetes.slave.files

restart_docker:
  cmd.run:
    - name: systemctl restart docker
