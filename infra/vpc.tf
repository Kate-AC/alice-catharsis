resource "aws_vpc" "current" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.current.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.current.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.current.id
  cidr_block              = "10.0.65.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id                  = aws_vpc.current.id
  cidr_block              = "10.0.66.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "${var.env}"
  }
}

