resource "kubernetes_namespace" "argocd-ns" {
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

resource "helm_release" "argocd" {
  depends_on = [kubernetes_namespace.argocd-ns]

  name          = "argocd"
  namespace     = kubernetes_namespace.argocd-ns
  repository    = "https://argoproj.github.io/argo-helm"
  chart         = "argo-cd"
  version       = "4.5.0"

}