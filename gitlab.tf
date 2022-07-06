# resource "kubernetes_namespace" "gitlab_ns" {
#   metadata {
#     annotations = {
#       name = "gitlab"
#     }
#     labels = {
#       role = "gitlab"
#     }
#     name = "gitlab"
#   }
# }

# resource "helm_release" "gitlab" {
#   depends_on = [kubernetes_namespace.gitlab_ns]

#   name          = "gitlab"
#   namespace     = kubernetes_namespace.gitlab_ns.metadata[0].name
#   repository    = "./helm/charts"
#   chart         = "gitlab"
#   version       = "6.1.0" 

#   values = [ 
#     file("./helm/charts/gitlab/values.yaml")
#   ]


# }