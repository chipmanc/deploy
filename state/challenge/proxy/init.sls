include:
  - challenge.proxy.pkg

haproxy_service:
  service.running:
    - name: haproxy
    - enable: True
    - watch:
      - file: /etc/haproxy/haproxy.cfg

/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://challenge/proxy/files/haproxy.cfg

