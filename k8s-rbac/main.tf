
# odic-identity pre-requisite

# data "kubernetes_namespace" "example" {
#   metadata {
#     name = "kube-system"
#   }
# }


# resource "kubernetes_cluster_role_binding_v1" "oidc_role" {
#   metadata {
#     generate_name = "odic-identity"
#   }

#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }
#   subject {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "Group"
#     name      = var.tfc_organization_name
#   }
# }