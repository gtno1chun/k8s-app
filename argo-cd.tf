resource "kubernetes_namespace" "argocd_ns" {
  metadata {
    annotations = {
      name = "argocd"
    }
    labels = {
      role = "argocd"
    }
    name = "argocd"
  }
}

resource "helm_release" "argo-cd" {
  depends_on = [kubernetes_namespace.argocd_ns]

  name          = "argo-cd"
  namespace     = kubernetes_namespace.argocd_ns.metadata[0].name
  repository    = "./helm/charts"
  chart         = "argo-cd"
  version       = "4.5.0"

}