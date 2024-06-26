resource "aws_security_group" "public_ec2_sg" {
  vpc_id      = var.vpc_id
  name        = "public_ec2_sg"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic and all outbound traffic"

  dynamic "ingress" {
    for_each = var.http_https_ports
    iterator = port
    content {
      description = "Allow inbound traffic"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "private_ec2_sg" {
  vpc_id      = var.vpc_id
  name        = "private_ec2_sg"
  description = "Allow all outbound traffic"

  ingress {
    description     = "Allow all inbound traffic from within the VPC"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = [var.vpc_cidr_block]
    security_groups = [aws_security_group.public_ec2_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id      = var.vpc_id
  name        = "rds_sg"
  description = "Allow MySQL traffic only from private EC2 instances"

  ingress {
    description     = "Allow MySQL traffic from private EC2 instances"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_ec2_sg.id]
  }
}
