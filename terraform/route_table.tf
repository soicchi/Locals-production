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

# Association #

resource "aws_route_table_association" "front_1a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.front_1a.id
}

resource "aws_route_table_association" "front_1c" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.front_1c.id
}

resource "aws_route_table_association" "back_1a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.back_1a.id
}

resource "aws_route_table_association" "back_1c" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.back_1c.id
}