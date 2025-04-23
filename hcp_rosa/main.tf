

module "hcp" {
  source = "github.com/hashi-demo-lab/terraform-rhcs-rosa-hcp.git"
  #source  = "terraform-redhat/rosa-hcp/rhcs"
  #version = "1.6.6-prerelease.2"

  cluster_name           = var.cluster_name
  openshift_version      = var.openshift_version
  machine_cidr           = var.cidr_block
  aws_subnet_ids         = concat(var.public_subnets, var.private_subnets)
  aws_availability_zones = var.availability_zones
  replicas               = length(var.availability_zones)

  // STS configuration
  create_account_roles  = true
  create_admin_user   = true
  account_role_prefix   = var.account_role_prefix
  create_oidc           = true
  create_operator_roles = true
  operator_role_prefix  = var.operator_role_prefix
  aws_billing_account_id = var.aws_billing_account_id
}

#
# OpenShift Rosa on AWS uses STS, aws_eks_cluster_auth is used to generate a short term STS token using cluster_id
data "aws_eks_cluster_auth" "openshift" {
   name =  module.hcp.cluster_id
}

locals {
  cluster_admin = base64encode("cluster-admin:${module.hcp.cluster_admin_password}")
  oauth_location = data.http.openshift_auth.response_headers.keys
}

data "http" "openshift_auth" {
  url = "https://oauth.${module.hcp.cluster_domain}/oauth/authorize?client_id=openshift-challenging-client&response_type=token"

  # base64 encoded
  request_headers = {
    Authorization = "Bearer ${local.cluster_admin}"
    X-CSRF-Token = "xxx"
    Content-Type  = "application/x-www-form-urlencoded"
  }
}

