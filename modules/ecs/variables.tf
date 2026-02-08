variable "subnet_ids" {
  description = "ECSタスクを配置するサブネット（private）"
  type        = list(string)
}

variable "sg_id" {
  description = "ECS用セキュリティグループID"
  type        = string
}

variable "tg_arn" {
  description = "ALB Target Group ARN"
  type        = string
}
