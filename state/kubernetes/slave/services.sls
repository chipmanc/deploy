kube-proxy:
  service.running:
    - enable: True

kubelet:
  service.running:
    - enable: True

flanneld:
  service.running:
    - enable: True
