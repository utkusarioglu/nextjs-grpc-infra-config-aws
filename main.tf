module "base" {
  source = "./modules/base/"

  cluster_name            = var.cluster_name
  cluster_version         = var.cluster_version
  name_prefix             = var.name_prefix
  main_network_block      = var.main_network_block
  subnet_prefix_extension = var.subnet_prefix_extension
  zone_offset             = var.zone_offset
  eks_managed_node_groups = var.eks_managed_node_groups
  autoscaling_average_cpu = var.autoscaling_average_cpu

  providers = {
    aws.dns_region = aws.dns_region
    aws            = aws
  }
}

module "config" {
  source = "./modules/config/"

  cluster_name                             = module.base.cluster_id
  spot_termination_handler_chart_name      = var.spot_termination_handler_chart_name
  spot_termination_handler_chart_repo      = var.spot_termination_handler_chart_repo
  spot_termination_handler_chart_version   = var.spot_termination_handler_chart_version
  spot_termination_handler_chart_namespace = var.spot_termination_handler_chart_namespace
  dns_base_domain                          = var.dns_base_domain
  ingress_gateway_name                     = var.ingress_gateway_name
  ingress_gateway_iam_role                 = var.ingress_gateway_iam_role
  ingress_gateway_chart_name               = var.ingress_gateway_chart_name
  ingress_gateway_chart_repo               = var.ingress_gateway_chart_repo
  ingress_gateway_chart_version            = var.ingress_gateway_chart_version
  external_dns_iam_role                    = var.external_dns_iam_role
  external_dns_chart_name                  = var.external_dns_chart_name
  external_dns_chart_repo                  = var.external_dns_chart_repo
  external_dns_chart_version               = var.external_dns_chart_version
  external_dns_values                      = var.external_dns_values
  name_prefix                              = var.name_prefix
  admin_users                              = var.admin_users
  developer_users                          = var.developer_users
  user_create_sleep_duration               = var.user_create_sleep_duration

  providers = {
    aws.dns_region = aws.dns_region
    aws            = aws
  }
}

module "app_prep" {
  source = "./modules/app-prep"

  project_root_path = var.project_root_rel_path
  helm_timeout_unit = var.helm_timeout_unit
  helm_atomic       = var.helm_atomic

  depends_on = [
    module.config
  ]
}

module "app" {
  source = "../../configs/app"

  project_root_rel_path = var.project_root_rel_path
  helm_timeout_unit     = var.helm_timeout_unit
  helm_atomic           = var.helm_atomic
  sld                   = var.sld
  tld                   = var.tld
  environment           = "aws"
  cluster_name          = var.cluster_name
  ingress_sg            = module.base.aws_alb_security_group_id


  depends_on = [
    module.app_prep
  ]
}
