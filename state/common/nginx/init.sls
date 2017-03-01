nginx:
  pkg.installed:
    - pkgs:
      - nginx
  service.running:
    - enable: True
    - require:
      - pkg: nginx
    - watch:
      - file: /etc/nginx/nginx.conf
  file.managed:
    - source: salt://common/nginx/files/nginx.conf
    - template: jinja
    - name: /etc/nginx/nginx.conf
