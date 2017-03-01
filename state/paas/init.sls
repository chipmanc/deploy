cloudera:
  pkgrepo.managed:
    - humanname: Cloudera Repo
    - baseurl: http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/4/
    - gpgcheck: 0

mesosphere_x64:
  pkgrepo.managed:
    - humanname: Mesosphere x86 Repo
    - baseurl: http://repos.mesosphere.io/el/7/$basearch/
    - gpgcheck: 0

mesosphere_noarch:
  pkgrepo.managed:
    - humanname: Mesosphere noarch Repo
    - baseurl: http://repos.mesosphere.io/el/7/noarch/
    - gpgcheck: 0

base_packages:
  pkg.installed:
    - pkgs:
      - epel-release
      - mesos
      - marathon
      - mesosphere-zookeeper
    - require:
      - pkgrepo: cloudera
      - pkgrepo: mesosphere_x64
      - pkgrepo: mesosphere_noarch
