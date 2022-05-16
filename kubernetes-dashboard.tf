resource "kubernetes_namespace" "k8s_dashboard_ns" {
  metadata {
    annotations = {
      name = "k8s-dashboard"
    }
    labels = {
      role = "k8s-dashboard"
    }
    name = "k8s-dashboard"
  }
}

resource "helm_release" "k8s-dashboard" {
  depends_on = [ kubernetes_namespace.k8s_dashboard_ns.name, ]

  name        = "kubernetes-dashboard" 
  namespace   = kubernetes_namespace.k8s_dashboard_ns.name
  repository  = "./helm/charts"
  chart       = "kubernetes-dashboard" 
  version     = "5.4.1"

  values = [ "${file("./helm/charts/kubernetes-dashboard/values.yaml")}" ] 

}