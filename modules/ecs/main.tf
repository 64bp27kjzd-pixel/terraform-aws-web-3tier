variable "subnet_ids" {}
variable "sg_id" {}
variable "tg_arn" {}

resource "aws_ecs_cluster" "this" {
  name = "phase1-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "nginx-task"
  requires_compatibilities = ["FARGATE"]
  cpu    = 256
  memory = 512
  network_mode = "awsvpc"

  container_definitions = jsonencode([
    {
      name  = "nginx"
      image = "nginx:latest"
      portMappings = [
        {
          containerPort = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [var.sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.tg_arn
    container_name   = "nginx"
    container_port   = 80
  }
}
