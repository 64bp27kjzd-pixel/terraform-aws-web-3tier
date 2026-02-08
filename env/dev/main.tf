module "vpc" {
  source = "../../modules/network/vpc"
  cidr   = var.vpc_cidr
  name   = "dev-vpc"
}

module "subnet" {
  source = "../../modules/network/subnet"
  vpc_id = module.vpc.id
  azs    = var.azs
}

module "rt" {
  source = "../../modules/network/route-table"
  vpc_id             = module.vpc.id
  public_subnet_ids  = module.subnet.public_subnet_ids
  private_subnet_ids = module.subnet.private_subnet_ids
}

module "sg" {
  source = "../../modules/security/security-group"
  vpc_id = module.vpc.id
}

module "alb" {
  source     = "../../modules/alb"
  subnet_ids = module.subnet.public_subnet_ids
  sg_id      = module.sg.alb_sg_id
  vpc_id     = module.vpc.id
}

module "ecs" {
  source     = "../../modules/ecs"
  subnet_ids = module.subnet.private_subnet_ids
  sg_id      = module.sg.ecs_sg_id
  tg_arn     = module.alb.tg_arn
}

module "vpc_endpoint" {
  source = "../../modules/network/vpc-endpoint"

  vpc_id                   = module.vpc.id
  private_subnet_ids        = module.subnet.private_subnet_ids
  endpoint_sg_id            = module.sg.ecs_sg_id
  private_route_table_ids   = [module.rt.private_route_table_id]
}

output "alb_dns" {
  value = module.alb.alb_dns
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}
