###vpc###
variable "vpc_name" {
  description = "name for the vpc"
  type        = string

}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the vpc"
}
variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type        = bool
}


variable "instance_tenancy" {
  description = " A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr."
  type        = string
  default     = "default"
}

variable "classic_link" {
  description = "should be true to enable classicLink for the vpc. Only valid in regions and accounts that support EC2 classic."
  type        = bool
  default     = false
}
variable "dns_support" {
  description = "should be true to enable dns support in the vpc"
  type        = bool
  default     = true
}
variable "enable_classiclink_dns_support" {
  description = "should be true to enable classicLink dns support for the vpc. Only valid in regions and accounts that support ec2 Classic."
  type        = bool
  default     = false
}
variable "enable_ipv6" {
  description = "requests an amazon-provided IPv6 cidr block with a /56 prefix length for the vpc. You cannot specify the range of IP addresses, or the size of the cidr block."
  type        = bool
  default     = false
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

#natgw
variable "enable_nat_gateway" {
  description = "whether to deploy a natgw to a subnet created"
  type = bool 
  
}

#tags

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the VPC resources"
}
variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

