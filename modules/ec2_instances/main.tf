resource "aws_instance" "public_instance" {
  ami                         = local.ami
  instance_type               = local.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.public_sg_id]
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  tags = {
    Name = "public-instance"
  }
}

resource "aws_instance" "private_instance" {
  ami                         = local.ami
  instance_type               = local.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.private_sg_id]
  subnet_id                   = var.private_subnet_id
  associate_public_ip_address = false
  tags = {
    Name = "private-instance"
  }
}
