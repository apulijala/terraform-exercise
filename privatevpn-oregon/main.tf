provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../vpc"
  region = var.region
  vpccidr = var.vpccidr
  public-subnets = var.public-subnets
  private-subnets = var.private-subnets
}

data "template_file" "instances" {
  template = "${file("${path.module}/instance.sh")}"
}

module "bastion" {
  // count = length(var.private_ips)
  source = "../instance"
  source_dest_check = false
  ami = local.amis[var.region]
  key_name = "practicalnetworking-oregon"
  subnet_id = module.vpc.public_subnet_ids[0]
  region = var.region
  user_data = data.template_file.instances.rendered
  assoc_public_ip = true
  instance_type = "t2.micro"
  prvt_ip = true
  inst_count = 1 // = var.private_ips[count.index]
  private_ips = var.private_ips
  vpc_id = module.vpc.vpc_id

}