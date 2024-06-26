variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_cidr_block" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "private_cidr_block" {
  type        = string
  description = "CIDR block for the private subnet"
}

variable "private_b_cidr_block" {
  type        = string
  description = "CIDR block for the second private subnet"
}

variable "public_availability_zone" {
  type        = string
  description = "Availability zone for the public subnet"
}

variable "private_availability_zone" {
  type        = string
  description = "Availability zone for the private subnet"
}

variable "private_b_availability_zone" {
  type        = string
  description = "Availability zone for the second private subnet"
}
