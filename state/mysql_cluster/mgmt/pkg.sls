remove:
  pkg.removed:
    - pkgs:
      - mariadb-libs

perl:
  pkg.installed:
    - pkgs:
      - libaio
      - perl-Class-MethodMaker
      - perl-Data-Dumper
      - perl-DBI

{% for package in pillar['mgmt_rpms'] %}
{{ package }}:
  cmd.run:
    - name: rpm -Uvh {{ pillar['base_url'] }}{{ package }}.rpm
    - unless:
      - rpm -q {{ package }}
{% endfor %}
