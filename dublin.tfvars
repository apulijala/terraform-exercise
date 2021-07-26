region="eu-west-1"

vpc-cidr = "10.10.10.0/24"
ami_id = "ami-058b1b7fe545997ae"
public-subnets = {

  "eu-west-1a" = {
    "Name" = "public-subnet-1"
    "cidr_block" = "10.10.10.0/27"
  }
  "eu-west-1b" = {
    "Name" = "public-subnet-2"
    "cidr_block" = "10.10.10.32/27"
  }

  "eu-west-1c" = {
    "Name" = "public-subnet-3"
    "cidr_block" = "10.10.10.64/27"
  }


}

private-subnets = {

  "eu-west-1a" = {
    "Name" = "private-subnet-1"
    "cidr_block" = "10.10.10.96/27"
  }
  "eu-west-1b" = {
    "Name" = "private-subnet-2"
    "cidr_block" = "10.10.10.128/27"
  }

  "eu-west-1c" = {
    "Name" = "private-subnet-3"
    "cidr_block" = "10.10.10.160/27"
  }
}
