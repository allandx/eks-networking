
module "vpc_1" {
  source               = "../../modules/vpc"
  vpc_name             = "app_vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy
  enable_nat_gateway   = var.vpc_1_enable_natgateway

  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
  project        = var.project
  environment    = var.environment
}

module "vpc_1_routes" {
  source              = "../../modules/routetable"
  depends_on          = [module.vpc_1]
  vpc_id              = module.vpc_1.vpc_id
  internet_gateway_id = module.igw_1.igw_id
  igw_create          = true

  private_nat_create = true
  nat_gateway_id     = [tostring(module.vpc_1.nat_gateway_id[0])]
  project            = var.project
  environment        = var.environment

  #nat_gateway_id               = [tostring(module.vpc_1.nat_gateway_id[0])]
}

#igw for vpc_1

module "igw_1" {
  source = "../../modules/internet_gateway"
  #depends_on  = [module.vpc_1]
  name        = "igw_1"
  vpc_id      = module.vpc_1.vpc_id
  project     = var.project
  environment = var.environment
}

module "SG_2" {
  source = "../../modules/security_group"
  name   = "sg_vpc_1"
  function_name        = var.vmname
  security_group_rules = var.security_group_rules
  vpc_id               = module.vpc_1.vpc_id
  project              = var.project
  environment          = var.environment
}

module "nacl" {
  source                      = "../../modules/nacl"
  default_network_acl_id      = module.vpc_1.default_network_acl_id #use vpc module output
  default_network_acl_ingress = var.default_network_acl_ingress
  default_network_acl_egress  = var.default_network_acl_egress
}

#for eks-fargate
module "eks_fargate" {
  depends_on = [module.vpc_1]
  source     = "../../modules/eks-fargate"
  vpc_id     = module.vpc_1.vpc_id
  project              = var.project
  environment          = var.environment
  cluster_name = var.cluster_name

}