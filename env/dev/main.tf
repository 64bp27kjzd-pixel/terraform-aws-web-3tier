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
  source      = "../../modules/network/route-table"
  vpc_id      = module.vpc.id
  subnet_ids  = module.subnet.public_subnet_ids
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
  subnet_ids = module.subnet.public_subnet_ids
  sg_id      = module.sg.ecs_sg_id
  tg_arn     = module.alb.tg_arn
}
