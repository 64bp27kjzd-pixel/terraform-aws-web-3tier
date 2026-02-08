variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}
