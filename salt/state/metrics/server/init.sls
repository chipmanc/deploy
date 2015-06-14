include:
  - common.nginx

graphite_packages:
  pkg.installed:
    - pkgs:
      - graphite-web
      - python-carbon
      - python-whisper
      - uwsgi
      - uwsgi-plugin-python
    - require_in:
      - carbon
      - uwsgi
grafana_package:
  pkg.installed:
    - sources:
      - grafana: https://grafanarel.s3.amazonaws.com/builds/grafana-2.6.0-1.x86_64.rpm
    - require_in:
      - grafana-server

graphite_prep:
  cmd.run:
    - name: |
        /usr/bin/graphite-manage syncdb --noinput
        /usr/bin/graphite-build-index
    - creates: /var/lib/graphite-web/graphite.db
    - require_in:
      - file: graphite_lib
  file.managed:
    - name: /etc/graphite-web/local_settings.py
    - source: salt://metrics/server/files/local_settings.py
    - user: grafana
    - group: grafana
    - template: jinja

carbon:
  service.running:
    - enable: True
    - name: carbon-cache
    - watch:
      - file: /etc/carbon/*
carbon.conf:
  file.managed:
    - name: /etc/carbon/carbon.conf
    - source: salt://metrics/server/files/carbon.conf
storage-schemas.conf:
  file.managed:
    - name: /etc/carbon/storage-schemas.conf
    - source: salt://metrics/server/files/storage-schemas.conf

grafana-server:
  service.running:
    - enable: True
    - watch:
      - file: /etc/grafana/grafana.ini
  file.managed:
    - source: salt://metrics/server/files/grafana.ini
    - name: /etc/grafana/grafana.ini
    - user: grafana
    - group: grafana

grafana.conf:
  file.managed:
    - source: salt://metrics/server/files/grafana.conf
    - template: jinja
    - name: /etc/nginx/conf.d/grafana.conf
graphite.conf:
  file.managed:
    - source: salt://metrics/server/files/graphite.conf
    - name: /etc/nginx/conf.d/graphite.conf

uwsgi:
  service.running:
    - enable: True
    - watch:
      - file: /etc/uwsgi.d/*
      - file: /etc/graphite-web/*
    - require:
      - file: graphite_lib
      - file: graphite_log
  file.managed:
    - source: salt://metrics/server/files/graphite.ini
    - template: jinja
    - name: /etc/uwsgi.d/graphite.ini
    - user: grafana
    - group: grafana

graphite_conf:
  file.directory:
    - name: /etc/graphite-web/
    - user: grafana
    - group: grafana
    - recurse:
      - user
      - group

graphite_lib:
  file.directory:
    - name: /var/lib/graphite-web
    - user: grafana
    - group: grafana
    - recurse:
      - user
      - group

graphite_log:
  file.directory:
    - name: /var/log/graphite-web
    - user: grafana
    - group: grafana
    - recurse:
      - user
      - group
