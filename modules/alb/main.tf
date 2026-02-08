variable "subnet_ids" {}
variable "sg_id" {}
variable "vpc_id" {}

resource "aws_lb" "this" {
  name               = "phase1-alb"
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.sg_id]
}

resource "aws_lb_target_group" "this" {
  name     = "phase1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

output "alb_dns" {
  value = aws_lb.this.dns_name
}

output "tg_arn" {
  value = aws_lb_target_group.this.arn
}
