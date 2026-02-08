output "repository_url" {
  value       = aws_ecr_repository.this.repository_url
  description = "The URI of the ECR repository"
}
