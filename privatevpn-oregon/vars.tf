variable "region" {}
variable "public-subnets" {}
variable "private-subnets" {}
variable "private_ips" {}
variable "vpccidr" {}
locals {
  amis = {
    "us-west-2" = "ami-083ac7c7ecf9bb9b0"
    "us-west-1" =  "ami-04b6c97b14c54de18"
  }
}
