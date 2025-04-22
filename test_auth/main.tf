# terraform k8s provider
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
required_version = ">= 1.11.0"
}

provider "kubernetes" {
    username = var.username
    password = var.password
    host     = var.host
}

provider "aws" {
  region = "ap-southeast-1"
}
data "aws_eks_cluster_auth" "example" {
  name =  "2i6vh00537t32a8d9igh8hgo10dpijt5"
}

output "auth" {
  value = nonsensitive(data.aws_eks_cluster_auth.example.token)
  
}

# data "kubernetes_namespace" "default" {
#   metadata {
#     name = "default"
#   }
# }

# output "namespace" {
#   value = data.kubernetes_namespace.default.metadata[0].name 
# }

# │ Error: namespaces "default" is forbidden: User "system:anonymous" cannot get resource "namespaces" in API group "" in the namespace "default"
# │ 
# │   with data.kubernetes_namespace.default,
# │   on main.tf line 18, in data "kubernetes_namespace" "default":
# │   18: data "kubernetes_namespace" "default" {



