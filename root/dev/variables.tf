###vpc###
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}
variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type        = bool
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type        = bool
}


variable "instance_tenancy" {
  description = " A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr."
  type        = string
}

#subnet
variable "public_subnet" {
  description = "list of public subnets"
  type        = list(any)
  default     = []
}
variable "private_subnet" {
  description = "list of Private subnets"
  type        = list(any)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  type        = bool
  default     = "false"
}

#igw
variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

# variable "vpc_id" {
#   type        = string
#   description = "Source VPC ID"
# }

#sg for vpc_1
variable "security_group_rules" {
  description = "Specify the security group inbound/outbound rules"
  default     = {}
}
variable "vmname" {
  description = "Provide the name for the EC2 instance"
  type        = string
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to resources"
}

#nacl
variable "default_network_acl_ingress" {
  description = "List of maps of ingress rules to set on the Default Network ACL"
  type        = list(map(string))
}

variable "default_network_acl_egress" {
  description = "List of maps of egress rules to set on the Default Network ACL"
  type        = list(map(string))
}

variable "vpc_1_enable_natgateway" {
  description = "Whether to deploy a natgw to subnet"
  type        = bool

}

variable "cluster_name" {
  description = "Name of cluster. Required value"
  type = string 
}