variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "http_https_ports" {
  type        = list(number)
  description = "List of ports to allow for HTTP and HTTPS"
  default     = [80, 443]
}

variable "ssh_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for SSH access"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block of the VPC"
}
