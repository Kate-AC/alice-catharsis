/* public */

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.current.id

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.current.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

/* private */

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.current.id

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.current.id

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_route" "private_a" {
  route_table_id         = aws_route_table.private_a.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_a.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_c" {
  route_table_id         = aws_route_table.private_c.id
  nat_gateway_id         = aws_nat_gateway.nat_gateway_c.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_c.id
}

