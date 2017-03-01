include:
  - base.iptables

jenkins_repo:
  cmd.run:
    - name: wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
    - creates: /etc/yum.repos.d/jenkins.repo

jenkins_key:
  cmd.run:
    - name: rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

jenkins:
  pkg.installed:
    - pkgs:
      - dejavu-sans-fonts
      - fontconfig
      - java-1.8.0-openjdk-headless
      - jenkins
      - python2-pip
  file.recurse:
    - user: jenkins
    - group: jenkins
    - name: /var/lib/jenkins
    - source: salt://jenkins/files/jenkins/
  service.running:
    - enable: True
    - require:
      - file: jenkins
  pip.installed:
    - name: jenkins-job-builder
