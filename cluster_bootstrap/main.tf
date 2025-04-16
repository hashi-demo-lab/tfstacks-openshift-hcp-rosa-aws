locals {
    vault_secrets_operator = file("${path.module}/manifests/vault-secrets-subscription.yaml")
    openshift_gitops_operator = file("${path.module}/manifests/openshift-gitops-subscription.yaml")
    openshift_gitops_operatorgroup = file("${path.module}/manifests/openshift-gitops-operatorgroup.yaml")
    openshift_pipelines_operator = file("${path.module}/manifests/openshift-pipelines-subscription.yaml")
}


# HashiCorp Vault Secrets Operator (VSO)
resource "kubernetes_namespace" "vso" {
  count = var.create_vso_namespace ? 1 : 0

  metadata {
    name = var.vso_namespace
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations["openshift.io/sa.scc.mcs"],
      metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
      metadata.0.annotations["openshift.io/sa.scc.uid-range"]
    ]
  }
}

resource "kubernetes_manifest" "vso" {
  depends_on = [ kubernetes_namespace.vso ]
  count    = var.enable_vso ? 1 : 0
  manifest = provider::kubernetes::manifest_decode(local.vault_secrets_operator)
}


# Red Hat OpenShift GitOps Operator
resource "kubernetes_namespace" "gitops_operator" {
  count = var.create_gitops_namespace ? 1 : 0

  metadata {
    name = var.gitops_namespace
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations["openshift.io/sa.scc.mcs"],
      metadata.0.annotations["openshift.io/sa.scc.supplemental-groups"],
      metadata.0.annotations["openshift.io/sa.scc.uid-range"],
      metadata.0.labels["security.openshift.io/scc.podSecurityLabelSync"]
    ]
  }
}

resource "kubernetes_manifest" "gitops_operatorgroup" {
  depends_on = [ kubernetes_namespace.gitops_operator ]
  count     = var.enable_gitops ? 1 : 0
  manifest  = provider::kubernetes::manifest_decode(local.openshift_gitops_operatorgroup)
}

resource "kubernetes_manifest" "gitops_operator" {
  depends_on = [ kubernetes_namespace.gitops_operator ]
  count     = var.enable_gitops ? 1 : 0
  manifest  = provider::kubernetes::manifest_decode(local.openshift_gitops_operator)
}

# Red Hat OpenShift Pipelines Operator
resource "kubernetes_manifest" "pipelines_operator" {
  count     = var.enable_pipelines ? 1 : 0
  manifest  = provider::kubernetes::manifest_decode(local.openshift_pipelines_operator)
}

