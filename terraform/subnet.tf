resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "locals-public-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "locals-public-1c"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.30.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "locals-private-1a"
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.40.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "locals-private-1c"
  }
}

resource "aws_subnet" "db_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.50.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "locals-db-1a"
  }
}

resource "aws_subnet" "db_1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.60.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "locals-db-1c"
  }
}