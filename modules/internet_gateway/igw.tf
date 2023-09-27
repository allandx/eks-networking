resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = merge(
  {
    Name = var.name,
    Project     = var.project,
    Environment = var.environment
    },
    var.tags
  )
}