provider "aws" {
  region = var.region
}

resource "aws_instance" "my_instance" {
  ami = var.ami
  count = length(var.private_ips) == 0 ? 1 : length(var.private_ips)
  instance_type = var.instance_type
  associate_public_ip_address = var.assoc_public_ip
  subnet_id = var.subnet_id
  source_dest_check = var.source_dest_check
  key_name = var.key_name
  user_data = var.user_data
  // private_ip = var.prvt_ip ? var.private_ips[count.index] : var.prvt_ip
  private_ip = var.private_ips[count.index]
  // vpc_security_group_ids = var.sec_group_id

}

