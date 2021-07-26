output "bastion_ip" {
  value = module.bastion.ip_address
}

output "instance_ips" {
  value = module.instances.ip_address
}