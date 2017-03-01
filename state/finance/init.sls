include:
  - common.nginx
  - common.uwsgi
  - finance.celery

base_setup:
  user.present:
    - name: finance
    - home: /srv/finance
    - require_in:
      - file: uwsgi_conf
  pkg.installed:
    - pkgs:
      - gcc
      - libxml2-devel
      - libxslt-devel
      - mariadb-devel
      - python-pip
      - python-virtualenv
  virtualenv.managed:
    - name: /srv/finance/
    - user: finance
    - requirements: salt://finance/files/requirements.txt
  pip.installed:
    - name: django-stocks
    - no_deps: True
    - bin_env: /srv/finance
    - upgrade: True
    - user: finance
    - index_url: https://testpypi.python.org/pypi
    - require:
      - virtualenv: base_setup
    - require_in:
      - file: systemd_script
    - watch_in:
      - service: uwsgi
  cmd.run:
    - name: |
        chmod 755 /srv/finance
        source /srv/finance/bin/activate
        django-admin.py startproject finance
        chmod +x finance/manage.py
    - onchanges:
      - virtualenv: base_setup
    - user: finance


uwsgi_conf:
  file.managed:
    - name: /etc/uwsgi.d/finance.ini
    - source: salt://finance/files/uwsgi_finance.ini
    - user: finance
    - group: finance


nginx_conf:
  file.managed:
    - name: /etc/nginx/conf.d/finance.conf
    - source: salt://finance/files/nginx_finance.conf
    - template: jinja


urls.py:
  file.managed:
    - name: /srv/finance/finance/finance/urls.py
    - source: salt://finance/files/urls.py
    - user: finance
    - group: finance
    - watch_in:
      - service: uwsgi
    - require:
      - cmd: base_setup


settings.py:
  file.managed:
    - name: /srv/finance/finance/finance/settings.py
    - source: salt://finance/files/settings.py
    - user: finance
    - group: finance
    - template: jinja
    - watch_in:
      - service: uwsgi
    - require:
      - cmd: base_setup
      - file: logging


collect_static:
  cmd.run:
    - name: |
        source /srv/finance/bin/activate
        cd /srv/finance/finance && ./manage.py collectstatic --noinput -l
    - user: finance
    - require:
      - file: settings.py


mock:
  pip.installed:
    - user: finance
    - bin_env: /srv/finance
    - require:
      - virtualenv: base_setup


logging:
  file.directory:
    - name: /var/log/finance
    - user: finance
    - group: finance
