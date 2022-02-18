resource "aws_eip" "ngw_1" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "ngw_2" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}