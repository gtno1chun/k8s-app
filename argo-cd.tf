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

# resource "helm_release" "argo-cd" {
#   depends_on = [kubernetes_namespace.argocd_ns]

#   name          = "argo-cd"
#   namespace     = kubernetes_namespace.argocd_ns.metadata[0].name
#   repository    = "./helm/charts"
#   chart         = "argo-cd"
#   version       = "4.5.0"

#   values = [
#     file("./helm/values/argocd_values.yaml")
#   ]

#   set {
#     name    = "repositories.name"
#     value   = "argocd-demo"
#   }
#   set {
#     name    = "repositories.type"
#     value   = "git"
#   }
#   set {
#     name    = "repositories.url"
#     value   = "https://github.com/jenana-devops/argocd-demo.git"
#   }

# }

# resource "kuberntes_service" "kubernetes-argocd" {
#   metadata {
#     name      = "argocd"
#     namespace = kubernetes_namespace.argocd_ns.metadata[0].name
#     annotations = {
#       "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" = "http"
#       "service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout" = "3600"
#       # "service.beta.kubernetes.io/aws-load-balancer-ssl-cert" = ""
#       # "service.beta.kubernetes.io/aws-load-balancer-ssl-ports" = "https" 
#     }

#     spec {
#       selector = {
#         "app" = "prometheus"
#       }
#       port {
#         port        =443 
#         target_port = 9090
#         protocol = "TCP"
#       }
#       type = "LoadBalancer"
#     }
#   }
# }
