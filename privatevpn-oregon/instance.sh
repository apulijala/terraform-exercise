#!/bin/bash
# set the command line for easy use.
echo 'alias c=clear; set -o vi' >> /etc/profile

# install common  requirements.
sudo yum install -y vim bash-completion
sudo amazon-linux-extras install -y epel
sudo yum install -y openvpn

echo "install the bash completion and vim"

