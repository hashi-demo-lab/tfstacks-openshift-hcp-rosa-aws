
#HCP ROSA
component "hcp_rosa" {

  source = "./hcp_rosa"

  inputs = {
    region = var.region
    cidr_block   = var.cidr_block
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    availability_zones = var.availability_zones
    cluster_name = var.cluster_name
    aws_billing_account_id = var.aws_billing_account_id
    openshift_version = var.openshift_version
    account_role_prefix = var.account_role_prefix
    operator_role_prefix = var.operator_role_prefix
    replicas = var.replicas
    htpasswd_idp_name = var.htpasswd_idp_name
    htpasswd_username = var.htpasswd_username
  }

  providers = {
    aws    = provider.aws.configurations
    rhcs  = provider.rhcs.this
    time = provider.time.this
    random = provider.random.this
    null = provider.null.this
  }
}

component "terraform_oidc" {
  depends_on = [component.hcp_rosa]
  
  source = "./k8s-rbac"
  
    inputs = {
      tfc_organization_name = var.tfc_organization_name
    }

    providers = {
      kubernetes = provider.kubernetes.config
    }
}



output "openshift_rosa_api_url" {
  description = "OpenShift API URL"
  value       = component.hcp_rosa.cluster_api_url
  type        = string
}

output "cluster_console_url" {
  description = "OpenShift Cluster Console URL"
  value       = component.hcp_rosa.cluster_console_url
  type        = string
}


