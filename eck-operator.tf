resource "kubernetes_namespace" "elastic_ns" {
  metadata {
    annotations = {
      name = "elastic"
    }
    labels = {
      role = "elastic"
    }
    name = "elastic"
  }
}

resource "helm_release" "elastic-operator" {
  depends_on = [kubernetes_namespace.elastic_ns]
  name          = "eck-operator"
  namespace     = kubernetes_namespace.elastic_ns.metadata[0].name
  repository    = "https://helm.elastic.co"
  chart         = "eck-operator"
  version       = "2.1.0"

}
resource "helm_release" "elasticsearch" {
  depends_on = [kubernetes_namespace.elastic_ns]
  name          = "elsticsearch"
  namespace     = kubernetes_namespace.elastic_ns.metadata[0].name
  repository    = "https://helm.elastic.co"
  chart         = "elasticsearch"
  version       = "7.17.1"

}
resource "helm_release" "filebeat" {
  depends_on = [kubernetes_namespace.elastic_ns]
  name          = "filebeat"
  namespace     = kubernetes_namespace.elastic_ns.metadata[0].name
  repository    = "https://helm.elastic.co"
  chart         = "filebeat"
  version       = "7.17.1"

}
resource "helm_release" "kibana" {
  depends_on = [kubernetes_namespace.elastic_ns]
  name          = "kibana"
  namespace     = kubernetes_namespace.elastic_ns.metadata[0].name
  repository    = "https://helm.elastic.co"
  chart         = "kibana"
  version       = "7.17.1"

}

resource "helm_release" "apm-server" {
  depends_on = [kubernetes_namespace.elastic_ns]
  name          = "apm-server"
  namespace     = kubernetes_namespace.elastic_ns.metadata[0].name
  repository    = "https://helm.elastic.co"
  chart         = "apm-server"
  version       = "7.17.1"

}

