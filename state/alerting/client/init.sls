check-mk-agent:
  pkg.installed:
    pkgs:
      - check-mk-agent
      - xinetd
  service.running:
    - enable: True
    - name: xinetd
   
