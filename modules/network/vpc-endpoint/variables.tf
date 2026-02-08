variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for Interface VPC Endpoints"
  type        = list(string)
}

variable "endpoint_sg_id" {
  description = "Security Group ID for Interface Endpoints"
  type        = string
}

variable "private_route_table_ids" {
  description = "Route table IDs for S3 Gateway Endpoint"
  type        = list(string)
}
