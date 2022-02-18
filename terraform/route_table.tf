# Route Table #

resource "aws_default_route_table" "default_rtb" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "locals-public-route-table"
  }
}

resource "aws_route_table" "private_1a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_1.id
  }

  tags = {
    Name = "locals-private-route-table"
  }
}

resource "aws_route_table" "private_1c" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_2.id
  }

  tags = {
    Name = "locals-private-route-table"
  }
}

# Association #

resource "aws_route_table_association" "public_1a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_1a.id
}

resource "aws_route_table_association" "public_1c" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_1c.id
}

resource "aws_route_table_association" "private_1a" {
  route_table_id = aws_route_table.private_1a.id
  subnet_id      = aws_subnet.private_1a.id
}

resource "aws_route_table_association" "private_1c" {
  route_table_id = aws_route_table.private_1c.id
  subnet_id      = aws_subnet.private_1c.id
}