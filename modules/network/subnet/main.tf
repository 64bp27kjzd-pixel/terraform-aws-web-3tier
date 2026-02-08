variable "vpc_id" {}
variable "azs" {}

resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index)
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.azs)
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet("10.0.0.0/16", 8, count.index + 10)
  availability_zone = var.azs[count.index]
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}