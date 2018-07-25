# Ansible Setup

{% if grains['os_family'] == "Ubuntu" %}

"Install Ansible PPA":
  pkgrepo.managed:
    - ppa: ansible/ansible

{% elseif grains['os_family'] == "RedHat" %}

"Install EPEL":
  pkgrepo.managed:
    - name: epel-source
    - humanname: Extra Packages for Enterprise Linux 6 - $basearch - Source
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$b
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
    - gpgcheck: 1
    - enabled: True

{% else %}

{% endif %}

"Install Dependencies":
  pkg.installed:
    - pkgs:
      - ansible
      - pyOpenSSL
      - python-cryptography
      - python-lxml
      
"Clone Openshift Git Repo":
  git.cloned:
    - name: github.com/openshift/openshift-ansible.git
    - target: /opt/openshift