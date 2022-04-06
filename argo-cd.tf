resource "kubernetes_namespace" "argocd_ns" {
  metadata {
    annotations = {
      name = "argo-cd"
    }
    labels = {
      role = "argo-cd"
    }
    name = "argo-cd"
  }
}

resource "helm_release" "argo-cd" {
  depends_on = [kubernetes_namespace.argocd_ns]

  name          = "argo-cd"
  namespace     = "kubernetes_namespace.argocd_ns"
  repository    = "https://argoproj.github.io/argo-helm"
  chart         = "argo-cd"
  version       = "4.5.0"

}