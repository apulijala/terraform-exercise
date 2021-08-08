region="us-west-2"
vpccidr="10.0.0.0/16"

public-subnets = {
  "us-west-2b" = {
    "Name" = "public-subnet-1"
    "cidr_block" = "10.0.0.0/24"
  }
}
private_ips = ["10.0.0.5"] # will pick it from here instead of defaults.
private-subnets = {

}