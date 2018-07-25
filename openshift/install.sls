# Install OpenShift

"Run OpenShift Playbook":
  ansible.playbook:
    - name: {{ playbook_name }}
    - rundir: /opt/openshift
    - ansible_kwargs: