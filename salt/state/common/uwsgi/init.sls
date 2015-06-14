uwsgi:
  pkg.installed:
    - pkgs:
      - uwsgi
      - uwsgi-plugin-python
  service.running:
    - enable: True
    - require:
      - pkg: uwsgi
    - watch:
      - file: /etc/uwsgi.d/*
