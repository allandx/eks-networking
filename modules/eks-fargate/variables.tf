variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  default = "1.26"
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}