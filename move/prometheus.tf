resource "kubernetes_namespace" "prometheus_ns" {
  metadata {
    annotations = {
      name = "prometheus"
    }
    labels = {
      role = "prometheus"
    }
    name = "prometheus"
  }
}

resource "helm_release" "prometheus" {
  depends_on = [
    kubernetes_namespace.prometheus_ns,
    #helm_release.ebs-csi-controller,
  ]

  repository    = "https://prometheus-community.github.io/helm-charts"
  chart         = "kube-prometheus-stack" 
  version       = "21.0.4" 
  name          = "prometheus" 
  namespace     = "prometheus"
  
  recreate_pods = true

  
  values = [ 
    file("./helm/charts/kube-prometheus-stack/values.yaml")
  ]

  # ## volume.beta.kubernetes.io/storage-provisioner: ebs.csi.aws.com
  # set {
  #   name  = "volume.beta.kubernetes.io/storage-provisioner"
  #   value = "ebs.csi.aws.com"
  # }
  
}

# resource "kubernetes_service" "prometheus_lb" {
#   depends_on = [
#     kubernetes_namespace.prometheus_ns,
#     helm_release.prometheus
#   ]
#   metadata {
#     name        = "prometheus-lb"
#     namespace   = "prometheus"
#     annotations = {
#       "app"                         = "kube-prometheus-stack-prometheus"
#       "app.kubernetes.io/instance"  = "prometheus"
#     }
#   }
#   spec {
#     selector = {
#       "app.kubernetes.io/name"  = "prometheus"
#       "prometheus"              = "prometheus-kube-prometheus-prometheus"
#     }
#     port {
#       port          = 443
#       target_port   = 9090
#       protocol      = "TCP"
#     }
#     type  = "LoadBalancer"
#   }
#   wait_for_load_balancer = true
# }