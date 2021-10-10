provider "aws" {
  region = var.region
}

module "vpc" {

  source = "../vpc"
  region = var.region
  vpccidr = "172.25.250.0/24"
  public-subnets = var.public-subnets
  private-subnets = var.private-subnets

}


data "template_file" "instances" {
  template = "${file("${path.module}/instance.sh")}"
}

module "instances" {
  // count = length(var.private_ips)
  source = "../instance"
  # ami = "ami-0ad8ecac8af5fc52b" # did not work. 
  ami = "ami-0035e9a03b5cd78c7"
  subnet_id = module.vpc.public_subnet_ids[0]
  region = var.region
  assoc_public_ip = true
  instance_type = "t2.medium"
  user_data = data.template_file.instances.rendered
  prvt_ip = true
  private_ips = var.private_ips
  key_name = "practicalnetworking"
  vpc_id = module.vpc.vpc_id

}

data "template_file" "install_ansible" {
  template = "${file("${path.module}/install_ansible.sh")}"
}

