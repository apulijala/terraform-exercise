region="us-west-1"
vpccidr="192.168.0.0/16"

public-subnets = {
  "us-west-1b" = {
    "Name" = "public-subnet-1"
    "cidr_block" = "192.168.4.0/24"
  }
}
private_ips = ["192.168.4.6", "192.168.4.7"] # will pick it from here instead of defaults.
private-subnets = {

}