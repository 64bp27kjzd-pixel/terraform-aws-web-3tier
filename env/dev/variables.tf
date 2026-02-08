variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}
