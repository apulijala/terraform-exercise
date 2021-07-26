variable "region" {
  default = "eu-west-2"
}


variable "ami" {
  default = "ami-0ad8ecac8af5fc52b "
}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {}


variable "assoc_public_ip" {
  default = "t2.micro"
}

variable "vpc_id" {

}

variable "prvt_ip" {
  default = false
}


variable "key_name" {
  default = "practicalnetworking"
}

variable "user_data" {
  default = ""
}

variable "inst_count" {
  default = 1
}

variable "private_ips" {
  default = []
}

