#!/bin/bash

#sleep 20
bastion_ip=$(terraform output | sed  -n -e 's/[," ]//g' -e '2 p')
echo "moving files to bastion $bastion_ip"

# move the files. 
scp -i machine_rsa ./machine_rsa root@$bastion_ip:/root/
scp -i  ./machine_rsa config root@$bastion_ip:/root/.ssh/config
scp -i  ./machine_rsa set_hostnames.sh root@$bastion_ip:/root/set_hostnames.sh

#set the correct permissions. 
ssh -i  ./machine_rsa root@$bastion_ip chmod 600 /root/.ssh/config
ssh -i  ./machine_rsa root@$bastion_ip chmod 600 /root/machine_rsa
ssh -i  ./machine_rsa root@$bastion_ip chmod +x /root/set_hostnames.sh; bash /root/set_hostnames.sh

alias bastion_ssh="ssh -i  ./machine_rsa root@$bastion_ip"
echo "to ssh to bastion just do bastion_ssh"

# ssh -i machine_rsa -l root $(terraform output | sed -n '1 p' | awk -F ' = ' '{print $2}')

