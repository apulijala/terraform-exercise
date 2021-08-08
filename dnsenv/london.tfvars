region="eu-west-2"


public-subnets = {
  "eu-west-2a" = {
    "Name" = "public-subnet-1"
    "cidr_block" = "192.168.0.0/24"
  }
}
private_ips = ["192.168.0.13", "192.168.0.14", "192.168.0.101", "192.168.0.105"] # will pick it from here instead of defaults.
private-subnets = {

}