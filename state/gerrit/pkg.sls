gerrit:
  pkg.installed:
    - pkgs:
      - git
      - gitweb
      - java-1.8.0-openjdk-headless
      - mysql-connector-java
      - python2-pip

dependencies:
  pip.installed:
    - pkgs:
      - requests
