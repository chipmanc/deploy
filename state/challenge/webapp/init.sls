include:
  - common.nginx
  - common.uwsgi
  - challenge.webapp.pkg
  - challenge.webapp.files

django:
  user.present:
    - home: /srv/django
    - require_in:
      - file: /etc/uwsgi.d/django.ini

virtualenvironment:
  pip.installed:
    - name: virtualenv
    - bin_env: /usr/bin/pip3
    - require:
      - pkg: packages
  virtualenv.managed:
    - name: /srv/django/
    - user: django
    - python: /usr/bin/python3
    - requirements: salt://challenge/webapp/files/requirements.txt
    - require:
      - file: /srv/django/malware
      - pip: virtualenvironment
      - pkg: packages
      - user: django

git_setup:
  git.latest:
    - name: https://github.com/chipmanc/engineering_challenge.git
    - target: /srv/django/malware
    - user: django
    - branch: master
    - force_reset: True
    - watch_in:
      - service: uwsgi
    - require:
      - virtualenv: virtualenvironment

migrate:
  cmd.run:
    - cwd: /srv/django/
    - name: |
        . bin/activate && malware/manage.py makemigrations && malware/manage.py migrate
    - require:
      - git: git_setup
