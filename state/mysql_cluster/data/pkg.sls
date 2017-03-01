remove:
  pkg.removed:
    - pkgs:
      - mariadb-libs

{% for package in pillar['data_rpms'] %}
{{ package }}:
  cmd.run:
    - name: rpm -Uvh {{ pillar['base_url'] }}{{ package }}.rpm
    - unless:
      - rpm -q {{ package }}
{% endfor %}
