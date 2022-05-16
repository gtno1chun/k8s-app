resource "kubernetes_namespace" "k8s-dashboard" {
  metadata {
    annotations = {
      name = "kubernetes-dashboard"
    }
    labels = {
      role = "kubernetes-dashboard"
    }
    name = "kubernetes-dashboard"
  }
}

# resource "helm_release" "k8s-dashboard" {
#   name        = "kubernetes-dashboard" 
#   repository  = "./helm/charts"
#   chart       = "kubernetes-dashboard" 
#   version     = "5.4.1"

#   values = [ "${file("./helm/charts/kubernetes-dashboard/values.yaml")}" ] 

# }