region="us-west-2"
vpccidr="192.168.0.0/16"

public-subnets = {
  "us-west-2b" = {
    "Name" = "public-subnet-1"
    "cidr_block" = "192.168.122.0/24"
  }
}
private_ips = ["192.168.122.5","192.168.122.6" ] # will pick it from here instead of defaults.
private-subnets = {

}