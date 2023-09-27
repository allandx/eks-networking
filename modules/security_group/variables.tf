variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to resources"
}
variable "name" {
  type        = string
  description = "Name of the sg"
}

variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}
variable "vpc_id" {
  type        = string
  description = "Source VPC ID"
}

variable "function_name" {
  type        = string
  description = "Specify the purpose for security group"
}

variable "security_group_rules" {
  description = "Specify the security group inbound/outbound rules"
  default     = {}
}

variable "create_sg" {
  type        = bool
  description = "Specify the value (True/False) whether security group needs to be created or not"
  default     = true
}