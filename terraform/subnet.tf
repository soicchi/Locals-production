resource "aws_subnet" "public_1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "locals-public-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "locals-public-1c"
  }
}
resource "aws_subnet" "private_1a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "locals-private-1a"
  }
}
resource "aws_subnet" "private_1c" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "locals-private-1c"
  }
}