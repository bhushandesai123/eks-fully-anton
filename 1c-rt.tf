resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                   # change to all 0
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${local.env}-pub-rt"
  }
}

resource "aws_route_table" "pvt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                      # change to all 0
    gateway_id = aws_nat_gateway.example.id       # change here add nat gateway above internet gateway
  }

  tags = {
    Name = "${local.env}-pvt-rt"
  }
}


#az 1a sub-association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub-1a.id
  route_table_id = aws_route_table.pub.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pvt-1a.id
  route_table_id = aws_route_table.pvt.id
}

# az 1b sub association
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.pub-1b.id
  route_table_id = aws_route_table.pub.id
}



resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.pub-1b.id
  route_table_id = aws_route_table.pvt.id
}