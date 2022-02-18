resource "aws_nat_gateway" "ngw_1" {
  allocation_id = aws_eip.ngw_1.id
  subnet_id     = aws_subnet.public_1a.id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "ngw_2" {
  allocation_id = aws_eip.ngw_2.id
  subnet_id     = aws_subnet.public_1c.id
  depends_on    = [aws_internet_gateway.igw]
}