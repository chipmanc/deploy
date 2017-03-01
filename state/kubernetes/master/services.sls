etcd:
  service.running:
    - enable: True
    - require_in:
      - service: kube-apiserver
      - service: kube-controller-manager
      - service: kube-scheduler

kube-apiserver:
  service.running:
    - enable: True

kube-controller-manager:
  service.running:
    - enable: True

kube-scheduler:
  service.running:
    - enable: True
