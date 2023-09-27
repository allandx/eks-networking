/*locals {
  ingress_rules = [{
    port        = 443
    description = "Ingress rules for port 443"
    },
    {
      port        = 80
      description = "Ingree rules for port 80"
  }]
}

resource "aws_security_group" "main" {
  name   = "sg for vpc_1"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = merge(
    {
      Name        = var.name,
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}
*/
#test dynamic block sg
resource "aws_security_group" "sg" {
  
  count       = var.create_sg ? 1 : 0
  name        = "sg${var.project}-${var.environment}-${var.function_name}"
  description = "security group for ${var.function_name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_group_rules["ingress"]
    content {
      description      = lookup(ingress.value, "description", null)
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
      security_groups  = lookup(ingress.value, "security_groups", null)
      prefix_list_ids  = lookup(ingress.value, "prefix_list_ids", null)
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null)
      #self             = lookup(ingress.value, "self", false)
    }
  }

  dynamic "egress" {
    for_each = var.security_group_rules["egress"]
    content {
      description      = lookup(egress.value, "description", null)
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = lookup(egress.value, "cidr_blocks", null)
      security_groups  = lookup(egress.value, "security_groups", null)
      prefix_list_ids  = lookup(egress.value, "prefix_list_ids", null)
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null)
      #self             = lookup(egress.value, "self", false)
    }
  }

  tags = merge(
    {
      Name        = var.name,
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}
