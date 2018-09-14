{% set id = salt.pillar.get('id') %}

"Bring Up To Date":
  salt.state:
    - tgt: {{ id }}
    - sls:
      - profiles.base.uptodate
      - profiles.base.redhat-subscription
      - profiles.base.pkg
      - profiles.base.uptodate

"Set Path":
  salt.function:
    - name: cmd.run
    - tgt: {{ id }}
    - arg:
      - export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

"Reboot 1":
  salt.function:
    - name: cmd.run
    - tgt: {{ id }}
    - arg:
      - shutdown -r -t 1

"Wait Reboot 1":
  salt.wait_for_event:
    - name: salt/minion/{{ id }}/start
    - id_list:
      - {{ id }} 
    - require:
      - salt: "Reboot 1"

"Install Atomic Pkgs":
  salt.function:
    - name: pkg.install
    - tgt: {{ id }}
    - arg:
      - atomic-openshift-utils

"Reboot 2":
  salt.function:
    - name: cmd.run
    - tgt: {{ id }}
    - arg:
      - shutdown -r -t 1

"Wait Reboot 2":
  salt.wait_for_event:
    - name: salt/minion/{{ id }}/start
    - id_list:
      - {{ id }}
    - require:
      - salt: "Reboot 2"

"Install Docker":
  salt.state:
    - tgt: {{ id }}
    - sls:
      - profiles.docker

"Manage OC Admin User":
  salt.state:
    - tgt: {{ id }}
    - sls:
      - profiles.openshift.admin-user
      - profiles.openshift.add-pubkey
      {% if id.startswith('dcaf-oc-master') %}
      - profiles.openshift.add-privkey
      {% endif %}
