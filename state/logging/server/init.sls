include:
  - logging

kibana:
  pkg.installed:
    - pkgs:
      - kibana
  service.running:
    - enable: True
