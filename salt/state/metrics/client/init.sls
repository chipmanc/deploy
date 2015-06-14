collectd:
  pkg.installed:
    - names:
      - collectd
      - collectd-iptables
      - collectd-mysql
      - collectd-nginx
      - collectd-openldap
  service.running:
    - enable: True
    - require:
      - pkg: collectd
    - watch:
      - file: /etc/collectd.d/*
  file.managed:
    - source: salt://metrics/client/files/baseline.conf
    - name: /etc/collectd.d/baseline.conf
    - template: jinja
