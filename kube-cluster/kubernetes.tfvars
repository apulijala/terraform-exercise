region = "eu-west-2"

public-subnets = {

  "eu-west-2a" = {
    "Name" = "public-subnet-1"
    "cidr_block" = "172.25.250.0/24"
  }
}

private-subnets = {
}

private_ips = ["172.25.250.10","172.25.250.11", "172.25.250.12" ]
