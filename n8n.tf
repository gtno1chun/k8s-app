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
  repository    = "https://8gears.container-registry.com/chartrepo/library/"
  chart         = "n8n"
  version       = "0.5.0"

}