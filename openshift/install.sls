# Run Ansible Playbook to install OpenShift

"Run OpenShift Prerequisites Playbook":
  ansible.playbook:
    - name: playbooks/prerequisites.yml
    - rundir: /opt/openshift
    - ansible_kwargs:
      inventory: inventory/hosts.localhost

"Run OpenShift Deploy_Cluster Playbook":
  ansible.playbook:
    - name: playbooks/deploy_cluster.yml
    - rundir: /opt/openshift
    - ansible_kwargs:
      inventory: inventory/hosts.localhost