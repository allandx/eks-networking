variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "internet_gateway_id" {
  type        = string
  description = "gateway_id to connect with the internet"
}

variable "igw_create" {
  type        = bool
  description = "True or false value if want to create a route to internet gateway for public subnet"
}
variable "private_nat_create" {
  description = "To see whether we want to add this route"
  type        = bool
}

variable "nat_gateway_id" {
  type        = list(any)
  description = "nat gateway id"

}

variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}


