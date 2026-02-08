output "alb_dns" {
  description = "ALBのDNS名"
  value       = aws_lb.this.dns_name
}

output "tg_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.this.arn
}

output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.this.arn
}
