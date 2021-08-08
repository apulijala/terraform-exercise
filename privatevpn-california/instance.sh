#!/bin/bash
# set the command line for easy use.
echo 'alias c=clear; set -o vi' >> /etc/profile

# install common  requirements.
sudo yum install -y vim bash-completion
echo "install the bash completion and vim"

