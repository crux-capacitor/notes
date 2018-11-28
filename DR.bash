# Disaster Recovery
# When the master keypair goes bye-bye.

for IP in `cat ips.txt`; do scp master.pub evan.gramens@$IP:~/minion_master.pub; done
for IP in `cat ips.txt`; do scp master.conf evan.gramens@$IP:~/99-master-address.conf; done
for IP in `cat ips.txt`; do ssh evan.gramens@$IP 'sudo mv /home/evan.gramens/minion_master.pub /etc/salt/pki/minion/minion_master.pub ; sudo mv /home/evan.gramens/99-master-address.conf /etc/salt/minion.d/ ; sudo systemctl restart salt-minion.service'; done
