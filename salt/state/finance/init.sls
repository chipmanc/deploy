include:
  - common.nginx
  - common.uwsgi

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
    - requirements: salt://finance/files/requirements.txt
    - user: finance
  pip.installed:
    - bin_env: /srv/finance
    - user: finance
    - ignore_installed: True
    - no_deps: True
    - index_url: https://testpypi.python.org/pypi
    - name: django-stocks
    - watch_in:
      - uwsgi
  cmd.run:
    - name: |
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
