variable "region" {}

variable "vpccidr" {}


variable "public-subnets" {
  default = {
      "us-east-1a" = {
        "Name" = "public-subnet-1"
        "cidr_block" = "192.168.0.0/19"
    }
      "us-east-1b" = {
        "Name" = "public-subnet-2"
        "cidr_block" = "192.168.32.0/19"
      }

      "us-east-1c" = {
        "Name" = "public-subnet-3"
        "cidr_block" = "192.168.64.0/19"
      }
      "us-east-1d" = {
        "Name" = "public-subnet-4"
        "cidr_block" = "192.168.96.0/19"
      }
  }
}

variable "private-subnets" {

  default = {
    "us-east-1a" = {
      "Name" = "private-subnet-1"
      "cidr_block" = "192.168.128.0/19"

    }
    "us-east-1b" = {
      "Name" = "private-subnet-2"
      "cidr_block" = "192.168.160.0/19"
    }

    "us-east-1c" = {
      "Name" = "private-subnet-3"
      "cidr_block" = "192.168.192.0/19"
    }

    "us-east-1d" = {
      "Name" = "private-subnet-4"
      "cidr_block" = "192.168.224.0/19"
    }
  }
}



