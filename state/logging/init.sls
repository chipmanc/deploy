repo:
  file.managed:
    - name: /etc/yum.repos.d/elastic.repo
    - source: salt://logging/files/elastic.repo
  cmd.run:
    - name:
        rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
    - onchanges:
      - file: repo

java:
  pkg.installed:
    - name: java-1.7.0-openjdk-headless

logstash:
  pkg.installed:
    - pkgs:
      - logstash
  service.running:
    - name: logstash
    - enable: True
    - require:
      - pkg: logstash
    - watch:
      - file: /etc/logstash/conf.d/*
  file.managed:
    - name: /etc/logstash/conf.d/base.conf
    - source: salt://logging/files/base.conf
