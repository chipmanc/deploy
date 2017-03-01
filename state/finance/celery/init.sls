systemd_script:
  file.managed:
    - source: salt://finance/files/celery.service
    - name: /usr/lib/systemd/system/celery.service
  service.running:
    - name: celery
    - enable: True
    - require:
      - file: systemd_script
    - watch:
      - pip: base_setup
