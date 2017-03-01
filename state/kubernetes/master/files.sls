apiserver:
  file.managed:
    - name: /etc/kubernetes/apiserver
    - source: salt://kubernetes/master/files/apiserver.tmpl
    - template: jinja
    - watch_in:
      - service: kube-apiserver

etcd_config:
  file.managed:
    - name: /etc/etcd/etcd.conf
    - source: salt://kubernetes/master/files/etcd.tmpl
    - template: jinja
    - watch_in:
      - service: etcd

config:
  file.managed:
    - name: /etc/kubernetes/config
    - source: salt://kubernetes/master/files/config.tmpl
    - template: jinja
    - watch_in:
      - service: kube-apiserver
      - service: kube-scheduler
      - service: kube-controller-manager
