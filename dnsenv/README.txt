

terraform apply --var-file london.tfvars
source ./move_config_keys.sh
bastion_ssh
on bastion execute set_hostnames
# 

