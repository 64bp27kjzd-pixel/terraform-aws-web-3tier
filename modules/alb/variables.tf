variable "subnet_ids" {
  description = "ALBを配置するサブネットID（public）"
  type        = list(string)
}

variable "sg_id" {
  description = "ALB用セキュリティグループID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
