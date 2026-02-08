output "alb_dns" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = module.ecs.cluster_id
}

output "ecr_nginx_repository_url" {
  value       = module.ecr_nginx.repository_url
  description = "The URI of the nginx ECR repository"
}
