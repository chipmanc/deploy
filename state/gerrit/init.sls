include:
  - gerrit.pkg
  - gerrit.db
  - base.iptables

gerrit_user:
  user.present:
    - name: gerrit
    - home: /home/gerrit

gerrit_download:
  cmd.run:
    - name: su gerrit -c 'wget https://gerrit-releases.storage.googleapis.com/gerrit-{{ pillar['version'] }}.war -O ~/gerrit-{{ pillar['version'] }}.war'
    - creates: /home/gerrit/gerrit-{{ pillar['version'] }}.war

gerrit_config:
  file.managed:
    - source: salt://gerrit/files/gerrit.config
    - name: /srv/gerrit/gerrit/etc/gerrit.config
    - makedirs: True
    - user: gerrit

gerrit_secure_config:
  file.managed:
    - source: salt://gerrit/files/secure.config
    - name: /srv/gerrit/gerrit/etc/secure.config
    - template: jinja

gerrit_install:
  file.directory:
    - name: /srv/gerrit/gerrit/etc/
    - user: gerrit
    - recurse:
      - user

gerrit_init:
  cmd.run:
    - name: su gerrit -c 'java -jar ~/gerrit-{{ pillar['version'] }}.war init -d /srv/gerrit/gerrit/ -b --no-auto-start --install-all-plugins'
    - creates: /srv/gerrit/gerrit/bin/
    - onchanges:
      - file: /srv/gerrit/gerrit/etc/gerrit.config

gerrit_cgi:
  file.copy:
    - name: /usr/lib/cgi-bin/gitweb.cgi
    - source: /var/www/git/gitweb.cgi
    - makedirs: True
 
gerrit_start:
  cmd.run:
    - name: su gerrit -c '/srv/gerrit/gerrit/bin/gerrit.sh restart'
    - onchanges:
      - cmd: gerrit_init

/tmp/initialize_gerrit.py:
  file.managed:
    - source: salt://gerrit/files/initialize.py
    - template: jinja
    - mode: 755

gerrit_initialize:
  cmd.run:
    - name: python /tmp/initialize_gerrit.py
