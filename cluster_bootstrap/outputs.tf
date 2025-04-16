output "vso_namespace" {
  description = "Namespace where Vault Secrets Operator is installed"
  value       = try(kubernetes_namespace.vso[0].metadata[0].name, null)
}

output "gitops_namespace" {
  description = "Namespace where OpenShift GitOps Operator is installed"
  value       = try(kubernetes_namespace.gitops_operator[0].metadata[0].name, null)
}

