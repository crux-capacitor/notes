# Ansible Setup

{% if grains['os_family'] == "Ubuntu" %}

"Install Ansible PPA":
  pkgrepo.managed:
    - ppa: ansible/ansible

{% elif grains['os_family'] == "RedHat" %}

{% if grains['os'] == "RedHat" or grains['os'] == "CentOS" %}
{% set release = grains['osmajorrelease'] %}

"Install EPEL":
  pkgrepo.managed:
    - name: epel-source
    - humanname: Extra Packages for Enterprise Linux {{ release }} - $basearch - Source
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-source-{{ release }}&arch=$basearch
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-{{ release }}
    - gpgcheck: 1
    - enabled: True

{% elif grains['os'] == "Fedora" %}

{% endif %}

{% endif %}

"Install Dependencies":
  pkg.installed:
    - pkgs:
      - ansible
      - pyOpenSSL
      - python-cryptography
      - python-lxml
      - java-1.8.0-openjdk-headless
      - patch
      - git