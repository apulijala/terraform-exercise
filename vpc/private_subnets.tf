# subnet_id
resource "aws_subnet" "private" {
  for_each = var.private-subnets
  cidr_block = each.value["cidr_block"]
  vpc_id = aws_vpc.vpc.id
  availability_zone = each.key
  tags = {
    "Name" =  each.value["Name"]
  }
}



# Elastic ip address.
resource "aws_eip" "elastic_ip" {
  count = length(keys(var.private-subnets))
  vpc  = true
}
# nat gatewy
resource "aws_nat_gateway" "my_nat" {

  count = length(keys(var.private-subnets))
  allocation_id = element(aws_eip.elastic_ip.*.id, count.index)
  subnet_id     = element(values(aws_subnet.public).*.id, count.index)
  tags = {
    Name = format("%s-%s","Nat-gateway",count.index )
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

#  Route table
resource "aws_route_table" "my_route_table" {
  count = length(keys(var.private-subnets))
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = format("%s-%s","private-route-table",count.index )
  }

}

resource "aws_route" "private-net-route" {

  count = length(keys(var.private-subnets))
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = element(aws_nat_gateway.my_nat.*.id,count.index)
  route_table_id         = element(aws_route_table.my_route_table.*.id,count.index)

}

resource "aws_route_table_association" "private" {
  count = length(keys(var.private-subnets))
  subnet_id      = element(values(aws_subnet.private).*.id, count.index)
  route_table_id = element(aws_route_table.my_route_table.*.id,count.index)

}






