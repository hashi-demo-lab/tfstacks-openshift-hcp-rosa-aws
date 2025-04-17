# terraform k8s provider
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
required_version = ">= 1.11.0"
}

provider "kubernetes" {
    username = var.username
    password = var.password
    host     = var.host
}

data "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
}

output "namespace" {
  value = data.kubernetes_namespace.default.metadata[0].name 
}

# │ Error: namespaces "default" is forbidden: User "system:anonymous" cannot get resource "namespaces" in API group "" in the namespace "default"
# │ 
# │   with data.kubernetes_namespace.default,
# │   on main.tf line 18, in data "kubernetes_namespace" "default":
# │   18: data "kubernetes_namespace" "default" {



