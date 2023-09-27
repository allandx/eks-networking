output "vpc_id" {
    value  = aws_vpc.vpc_1.id
}

output "default_network_acl_id" {
   value= aws_vpc.vpc_1.default_network_acl_id
}

output "nat_gateway_id" {
  description = "returns a string"
  value       = aws_nat_gateway.natgw[*].id
  
  }