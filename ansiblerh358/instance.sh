#!/bin/bash

SSH_PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEx/CYVmnu508hiAHWXpEEc+b30rAndUFV7iOajvcfXrzGAq1cH0ADz7eyjFyqhY/M0q/Bi4xiV0vHhiAyoyTB9glW5LIlFmxGGhkFPY766AcNlhfgGBGR1RqzxghxndtqqlT2jfELGoih62wZ2734JHrvd3+HSmSQWsXWQmkqNjDCCIZVoCwQZNI0h3yl/jxD9tZLH+tkE2TFzuAtSGVtax2WCVLdgRPBn/1JbFASNlWRIz58PIsytsIPzpjobIFATO4RqTdmnPiNZwc6NxKbo5saTr86qZNPXu9QM66supSjyUAP4pGYmi8aG2cbERP2xEXqfc/I4+8crQVChdGPn5pHiTC9+dcjzbSP1UTb1Uak7rBrZJAbOhiuctBGA8MxdT9XeVDnagR4IHaeMw2CCHNiojyuodZBcFI9MW3mXLIZlFMbNeII+wMtouv2I5CMbJB1zZvx028LWulRH1cHXC+6kfYoLNMcRywxg4XDqIB66vitddoUS02KBJUaW20= arvind@arvind-Proteus"
SSH_DIR="/root/.ssh"

LOGFILE="/tmp/log"
id >> "$LOGFILE"
echo "staring the script" >> "$LOGFILE"



# set the command line for easy use.
echo 'alias c=clear; set -o vi' >> /etc/profile
echo "set the profile" >> "$LOGFILE"
# install common  requirements.
sudo yum install -y vim bash-completion
echo "install the bash completion and vim" >> "$LOGFILE"

# ssh config changes.
sed -E -i.bak 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd
echo "Restarted the ssh" >> "$LOGFILE"
"[[ -d $SSH_DIR ]] || mkdir -p $SSH_DIR"

#  adjust so root can login to ssh.
# could not write to authorized keys directly.
echo "$SSH_PUB_KEY" >> /tmp/authorized_keys
cp /tmp/authorized_keys "$SSH_DIR/authorized_keys"
echo "Installed authorized keys" >> "$LOGFILE"
chmod 600 "$SSH_DIR/authorized_keys"
echo "All done" >> "$LOGFILE"

# Install and enable firewalld.
yum install -y firewalld
systemctl enable --now firewalld
