#vpc#
vpc_cidr_block       = "10.0.0.0/16"
enable_dns_support   = "true"
enable_dns_hostnames = "true"
instance_tenancy     = "default"

#subnet#
# list of public subnet if want to create, if not,delete block. Add on cidr and az to create more subnets
public_subnet = [
  {
    cidr = "10.0.0.0/24",
    az   = "ap-southeast-1a"
  },
  {
    cidr = "10.0.1.0/24",
    az   = "ap-southeast-1b"
  }

]

# list of private subnet if want to create, if not,delete 
private_subnet = [
  {
    cidr = "10.0.3.0/24",
    az   = "ap-southeast-1a"
  },
  {
    cidr = "10.0.4.0/24",
    az   = "ap-southeast-1b"
  }
]

#projectand env tags

project     = "hdb"
environment = "dev"

#sg for vpc_1
# Able to add more ingress/egress rules to the sg 

vmname = "vpc_1"
security_group_rules = {
  ingress = [
    { description = "allow http traffic"
      from_port   = 80,
      to_port     = 80,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    },
    { description = "allow https traffic "
      from_port   = 443,
      to_port     = 443,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress = [
    { description = "allow all traffic"
      from_port   = 0,
      to_port     = 0,
      protocol    = "-1",
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

#add egress if necc.
#for nacl
default_network_acl_ingress = [
  {
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  },
  {
    rule_no         = 101
    action          = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]

default_network_acl_egress = [
  {
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  },
  {
    rule_no         = 101
    action          = "allow"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_block = "::/0"
  },
]

#natgw for vpc_1
vpc_1_enable_natgateway = true

#eks
cluster_name = "demo"