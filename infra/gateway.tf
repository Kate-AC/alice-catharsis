resource "aws_internet_gateway" "current" {
  vpc_id = aws_vpc.current.id

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_eip" "nat_gateway_a" {
  vpc        = true
  depends_on = [aws_internet_gateway.current]

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_eip" "nat_gateway_c" {
  vpc        = true
  depends_on = [aws_internet_gateway.current]

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_gateway_a.id
  subnet_id     = aws_subnet.public_a.id
  depends_on    = [aws_internet_gateway.current]

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_nat_gateway" "nat_gateway_c" {
  allocation_id = aws_eip.nat_gateway_c.id
  subnet_id     = aws_subnet.public_c.id
  depends_on    = [aws_internet_gateway.current]

  tags = {
    Name = "${var.env}"
  }
}

