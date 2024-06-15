

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.pub-1a.id

  tags = {
    Name = "${local.env}-nat"
  }
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}