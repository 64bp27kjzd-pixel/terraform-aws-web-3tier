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

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "image" {
  type        = string
  description = "Container image URI for ECS task"
}
