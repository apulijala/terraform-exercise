provider "aws" {
  region = var.region
}

/*
module "vpc" {

  source = "../vpc"
  region = var.region
  vpccidr = "172.25.250.0/24"
  public-subnets = var.public-subnets
  private-subnets = var.private-subnets

}
*/


data "aws_vpc" "selected" {
  default = true
}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id ]
  }
}

data "template_file" "instances" {
  template = "${file("${path.module}/instance.sh")}"
}

module "instances" {
  // count = length(var.private_ips)
  source = "../instance"
  ami = "ami-0ad8ecac8af5fc52b"
  subnet_id =  data.aws_subnets.example.ids[0]    // module.vpc.public_subnet_ids[0]
  region = var.region
  assoc_public_ip = true
  instance_type = "t2.micro"
  user_data = data.template_file.instances.rendered
  prvt_ip = true
  private_ips = var.private_ips
  key_name = "practicalnetworking"
  vpc_id = data.aws_vpc.selected.id   // module.vpc.vpc_id

}

data "template_file" "install_ansible" {
  template = "${file("${path.module}/install_ansible.sh")}"
}

module "bastion" {
  // count = length(var.private_ips)
  source = "../instance"
  ami = "ami-0ad8ecac8af5fc52b"
  key_name = "practicalnetworking"
  subnet_id = data.aws_subnets.example.ids[0]  // module.vpc.public_subnet_ids[0]
  region = var.region
  user_data =   data.template_file.install_ansible.rendered
  assoc_public_ip = true
  instance_type = "t2.micro"
  prvt_ip = false
  // inst_count = 5 // = var.private_ips[count.index]
  private_ips = ["172.31.16.11"]
  vpc_id =  data.aws_vpc.selected.id // module.vpc.vpc_id

}
