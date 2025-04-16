# output "oidc_binding_id" {
#   value = kubernetes_cluster_role_binding_v1.oidc_role.id
# }

output "namespaces" {
  value = data.kubernetes_all_namespaces.allns.namespaces
}