provider "aws" {
  region = var.region
}

# --------------------
# VPC
# --------------------
module "vpc" {
  source = "../../modules/network/vpc"

  cidr = var.vpc_cidr
  name = var.vpc_name
}

# --------------------
# Subnet
# --------------------
module "subnet" {
  source = "../../modules/network/subnet"

  vpc_id = module.vpc.vpc_id
  azs    = var.azs
}

# --------------------
# Route Table
# --------------------
module "route_table" {
  source = "../../modules/network/route-table"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.subnet.public_subnet_ids
  private_subnet_ids = module.subnet.private_subnet_ids
}

# --------------------
# Security Group
# --------------------
module "sg" {
  source = "../../modules/network/security-group"

  vpc_id = module.vpc.vpc_id
}

# --------------------
# ALB
# --------------------
module "alb" {
  source = "../../modules/alb"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.subnet.public_subnet_ids
  sg_id      = module.sg.alb_sg_id
}

# --------------------
# VPC Endpoint
# --------------------
module "vpc_endpoint" {
  source = "../../modules/vpc-endpoint"

  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.subnet.private_subnet_ids
  sg_id           = module.sg.ecs_sg_id
  route_table_ids = module.route_table.private_route_table_ids
}

# --------------------
# ECS
# --------------------
module "ecs" {
  source = "../../modules/ecs"

  subnet_ids = module.subnet.private_subnet_ids
  sg_id      = module.sg.ecs_sg_id
  tg_arn     = module.alb.tg_arn
}
