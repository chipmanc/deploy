kubelet_config:
  file.managed:
    - name: /etc/kubernetes/kubelet
    - source: salt://kubernetes/slave/files/kubelet.tmpl
    - template: jinja
    - watch_in:
      - service: kubelet

proxy_config:
  file.managed:
    - name: /etc/kubernetes/config
    - source: salt://kubernetes/slave/files/config.tmpl
    - template: jinja
    - watch_in:
      - service: kube-proxy

flannel:
  file.managed:
    - name: /etc/sysconfig/flanneld
    - source: salt://kubernetes/slave/files/flanneld.tmpl
    - template: jinja
    - watch_in:
      - service: flanneld
