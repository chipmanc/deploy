/etc/uwsgi.d/django.ini:
  file.managed:
    - source: salt://challenge/webapp/files/django_malware.ini
    - user: django
    - group: django
    - watch_in:
      - service: uwsgi
      
/etc/nginx/conf.d/django_malware.conf:
  file.managed:
    - source: salt://challenge/webapp/files/django_malware.conf
    - template: jinja
    - watch_in:
      - service: nginx

/srv/django/malware:
  file.directory:
    - user: django
    - require:
      - user: django

/srv/django/malware/engineering_challenge/secret:
  file.managed:
    - source: salt://challenge/webapp/files/secret
    - user: django
    - group: django
    - require:
      - git: git_setup
    - watch_in:
      - service: uwsgi

/srv/django/malware/engineering_challenge/settings.py:
  file.managed:
    - source: salt://challenge/webapp/files/settings.py
    - user: django
    - group: django
    - template: jinja
    - require:
      - git: git_setup
    - watch_in:
      - service: uwsgi
