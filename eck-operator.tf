# resource "kubernetes_namespace" "eck_ns" {
#   metadata {
#     annotations = {
#       name = "eck"
#     }
#     labels = {
#       role = "eck"
#     }
#     name = "eck"
#   }
# }

# resource "helm_release" "eck-operator" {
#   depends_on = [kubernetes_namespace.eck_ns]

#   name          = "eck-operator"
#   namespace     = kubernetes_namespace.eck_ns.metadata[0].name
#   repository    = "https://helm.elastic.co"
#   chart         = "eck-operator"
#   version       = "2.1.0"

# }


