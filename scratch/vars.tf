variable "public-subnets" {
  type = map(map(string))
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
