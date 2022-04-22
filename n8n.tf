resource "kubernetes_namespace" "n8n_ns" {
  metadata {
    annotations = {
      name = "n8n"
    }
    labels = {
      role = "n8s"
    }
    name = "n8n"
  }
}

resource "helm_release" "n8s" {
  depends_on = [kubernetes_namespace.n8n_ns]

  name          = "n8n"
  namespace     = kubernetes_namespace.n8n_ns.metadata[0].name
  repository    = "https://helm.linogics.io"
  chart         = "linogics/n8n"
  version       = "0.136.0"

}