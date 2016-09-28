{% from "global/map.jinja" import openstack_version with context %}

{% if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7' %}
epel-release:
  pkg:
    - installed

packages:
  pkg.installed:
    - pkgs:
      - python-pip
      - ntp
      - python-docker-py
      - docker
      - docker-logrotate
      - gcc
      - python-devel
      - git
    - require:
      - pkg: epel-release

ntpd:
  service.running:
    - name: ntpd
    - enable: True
    - require:
      - pkg: packages

docker:
  service.running:
    - name: docker
    - enable: True
    - require:
      - pkg: packages

pip:
  pip.installed:
    - name: pip
    - upgrade: True
    - require:
      - pkg: packages

{% if openstack_version == 'mitaka' %}
ansible1.9:
  pkg:
    - installed
    - require:
      - pkg: epel-release
{% endif %}

kolla:
  pip.installed:
    - cwd: /tmp
    - name: git+https://github.com/openstack/kolla.git@stable/{{ openstack_version }}
    - upgrade: True
    - require:
      - pip: pip

{% endif %}