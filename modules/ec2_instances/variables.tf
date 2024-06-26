variable "key_name" {
  type        = string
  description = "SSH key name"
}

variable "public_sg_id" {
  type        = string
  description = "Security group ID for public instance"
}

variable "private_sg_id" {
  type        = string
  description = "Security group ID for private instance"
}

variable "public_subnet_id" {
  type        = string
  description = "Subnet ID for public instance"
}

variable "private_subnet_id" {
  type        = string
  description = "Subnet ID for private instance"
}
