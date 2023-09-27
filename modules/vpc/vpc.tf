resource "aws_vpc" "vpc_1" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_classiclink               = var.classic_link
  enable_dns_support               = var.dns_support
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6


  tags = merge(
    {
      Name        = var.vpc_name,
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}
#public subnet
resource "aws_subnet" "pub_sub" {
  count = length(var.public_subnet) > 0 ? length(var.public_subnet) : 0
  #cidr_block = "10.1.1.0/24"
  vpc_id = aws_vpc.vpc_1.id

  cidr_block              = lookup(var.public_subnet[count.index], "cidr")
  map_public_ip_on_launch = var.map_public_ip_on_launch #makes subnet public
  availability_zone       = lookup(var.public_subnet[count.index], "az")
  #availability_zone= data.aws_availability_zones.available.names[count.index]
  tags = merge({ Name = "${var.vpc_name}_pub_sub_${count.index + 1}", project= var.project,environment=var.environment})
}

#private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_1.id
  count             = length(var.private_subnet) > 0 ? length(var.private_subnet) : 0
  cidr_block        = lookup(var.private_subnet[count.index], "cidr")
  availability_zone = lookup(var.private_subnet[count.index], "az")
  tags              = merge({ Name = "${var.vpc_name}-pvt_sub_${count.index + 1}", project= var.project,environment=var.environment})
}


#Create pub nat gw

resource "aws_eip" "nat_ip" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "natgw" {
  count = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.pub_sub[0].id

  tags = {
    Name = "nat"
  }

  
}



#route table


#vpc security group
