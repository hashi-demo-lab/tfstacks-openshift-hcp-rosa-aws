required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
  }

  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "~> 2.3"
  }

  time = {
    source = "hashicorp/time"
    version = "~> 0.1"
  }
  random = {
    source = "hashicorp/random"
    version = "~> 3.0"
  }
  null = {
    source = "hashicorp/null"
    version = "~> 3.0"
  }
  rhcs = {
    source = "terraform-redhat/rhcs"
    version = "~> 1.6"
  }
  

}

provider "aws" "configurations" {

  config {
    region = var.region

    assume_role_with_web_identity {
      role_arn                = var.role_arn
      web_identity_token = var.aws_identity_token
    }
  }
}

provider "rhcs" "this" {
  config {
    token  = var.rhcs_token
  }
}

provider "kubernetes" "config" {
  config { 
    host = component.hcp_rosa.cluster_api_url
    username = "cluster-admin/api-b7k4y6g3t8e7y8r-p09d-p3-openshiftapps-com:443"
    password = var.cluster_admin_password
  }
}


provider "random" "this" {}
provider "time" "this" {} 
provider "null" "this" {}