terraform apply --var-file ansible.tfvars
./move_config_keys.sh
# 

All Git repos for DO447 Practice
forks_ques  tags_project  user_list  web_install

Vimrc settings. 
~/.vimrc
autocmd FileType yaml setlocal ai ts=2 sw=2 et
autocmd FileType yml  setlocal ai ts=2 sw=2 et
set cursorcolumn

Ansible Installation
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum install -y ansible

