resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public_availability_zone
}

resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidr_block
  availability_zone = var.private_availability_zone
}

resource "aws_subnet" "private_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_b_cidr_block
  availability_zone = var.private_b_availability_zone
}
