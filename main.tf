module "key_pair" {
  source     = "./modules/key_pair"
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub")
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source                      = "./modules/subnets"
  vpc_id                      = module.vpc.vpc_id
  public_cidr_block           = "10.0.1.0/24"
  private_cidr_block          = "10.0.2.0/24"
  private_b_cidr_block        = "10.0.3.0/24"
  public_availability_zone    = "ap-south-1a"
  private_availability_zone   = "ap-south-1a"
  private_b_availability_zone = "ap-south-1b"
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source     = "./modules/route_table"
  vpc_id     = module.vpc.vpc_id
  gateway_id = module.internet_gateway.internet_gateway_id
  subnet_id  = module.subnets.public_subnet_id
}

module "security_groups" {
  source          = "./modules/security_groups"
  vpc_id          = module.vpc.vpc_id
  ssh_cidr_blocks = ["111.93.177.58/32", "125.20.111.58/32"]
  vpc_cidr_block  = "10.0.0.0/16"
}

module "ec2_instances" {
  source            = "./modules/ec2_instances"
  key_name          = module.key_pair.key_name
  public_sg_id      = module.security_groups.public_ec2_sg_id
  private_sg_id     = module.security_groups.private_ec2_sg_id
  public_subnet_id  = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
}

module "rds" {
  source               = "./modules/rds"
  db_subnet_group_name = "my-db-subnet-group"
  subnet_ids           = [module.subnets.private_subnet_id, module.subnets.private_b_subnet_id]
  rds_sg_id            = module.security_groups.rds_sg_id
}
