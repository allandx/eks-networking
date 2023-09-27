resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  tags = { Name = "public rt"
           Project     = var.project,
           Environment = var.environment
   }

}


data "aws_subnets" "public" {

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*pub_sub*"
  }


}

# #Public Route association. 
resource "aws_route_table_association" "public_rt_association" {
  depends_on     = [aws_route_table.public_rt]
  count          = length(data.aws_subnets.public.ids)
  subnet_id      = data.aws_subnets.public.ids[count.index]
  route_table_id = aws_route_table.public_rt.id
}

#create route for igw in pub rt
resource "aws_route" "public_igw" {
  count                  = var.igw_create ? 1 : 0
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id

}
###
# Private route
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  tags = {Name = "private rt"
          Project     = var.project,
          Environment = var.environment}

}

resource "aws_route" "private_nat_gateway" {
  count                  = var.private_nat_create ? 1 : 0
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_id[0]

}


data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "*pvt_sub*"
  }

}
resource "aws_route_table_association" "private-0" {
  depends_on     = [aws_route_table.private_rt]
  route_table_id = aws_route_table.private_rt.id
  count          = length(data.aws_subnets.private.ids)
  subnet_id      = data.aws_subnets.private.ids[count.index]

}
