provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpccidr # "192.168.0.0/16" # var.vpc-cidr
  enable_dns_hostnames = true

}

resource "aws_default_security_group" "default" {
  vpc_id =  aws_vpc.vpc.id

  ingress {
    self      = true
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port   = 0

  }

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public" {
  for_each = var.public-subnets
  cidr_block = each.value["cidr_block"]
  vpc_id = aws_vpc.vpc.id
  availability_zone = each.key
  tags = {
    "Name" =  each.value["Name"]
  }
}

resource "aws_route_table" "subnet-route-table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "public" {
  # for_each =     toset(values(aws_subnet.public).*.id) // aws_subnet.public.*.id did not work.
  // count = 4 worked.
  // count = length(toset(values(aws_subnet.public).*.id)). did not work.
  // each.key  //element(aws_subnet.public.*.id, count.index )  # element(aws_subnet.public.*.id, count.index)
  count = length(keys(var.public-subnets))
  # because for_eaach makes the list also as a mp
  # because for_eaach makes the list also as a mp
  subnet_id      = element(values(aws_subnet.public).*.id, count.index)
  route_table_id = aws_route_table.subnet-route-table.id
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "subnet-route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.subnet-route-table.id
}




