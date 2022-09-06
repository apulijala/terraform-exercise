region = "eu-west-2"

public-subnets = {
  "eu-west-2a" = {
    "Name" = "public-subnet-1"
    "cidr_block" = "172.25.250.0/24"
  }
}

private-subnets = {

}

private_ips = ["172.31.16.21","172.31.16.22", "172.31.16.23","172.31.16.24" ]