region="us-west-1"
vpccidr="172.16.0.0/16"

public-subnets = {
  "us-west-1b" = {
    "Name" = "public-subnet-1"
    "cidr_block" = "172.16.0.0/24"
  }
}
private_ips = ["172.16.0.5"] # will pick it from here instead of defaults.
private-subnets = {

}