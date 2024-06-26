resource "aws_db_subnet_group" "default" {
  name = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = local.engine_version
  instance_class         = local.instance_class
  db_name                = "mydb"
  username               = local.username
  password               = local.password
  parameter_group_name   = local.parameter_group_name
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = {
    Name = "my-rds-db"
  }
}
