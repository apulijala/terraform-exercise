provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
  region = var.region
  vpccidr =  var.vpc-cidr
  private-subnets = var.private-subnets
  public-subnets = var.public-subnets
}
module "alb" {
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  asg_arn = module.asg.asg_arn
  subnets = module.vpc.public_subnet_ids
  public_subnet_id = module.vpc.public_subnet_ids[0]
  ami_id = var.ami_id
}

module "asg" {
  source = "./asg"
  region = var.region
  vpc_id = module.vpc.vpc_id
  vpc_zones = module.vpc.private_subnet_ids
  sec_group = module.alb.alb_sec_grp_id
  alb_target_group_arn = module.alb.alb_target_group_id
  ami_id = var.ami_id

}



