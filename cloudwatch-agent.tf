resource "kubernetes_namespace" "cloudwatch_ns" {
  metadata {
    annotations = {
      name = "cloudwatch"
    }
    labels = {
      role = "cloudwatch"
    }
    name = "cloudwatch"
  }
}

resource "helm_release" "cloudwatch-agent" {
  depends_on = [
    kubernetes_namespace.cloudwatch_ns,
    #helm_release.ebs-csi-controller,
  ]

  repository    = "https://s2504s.github.io/charts"
  chart         = "cloudwatch-agent"  
  version       = "0.0.1" 
  name          = "cloudwatch-agent" 
  namespace     = "cloudwatch"
  
  #recreate_pods = true
  values = [ 
    file("./helm/charts/cloudwatch-agent/values.yaml")
  ]
  
  /*
  set {
    name  = "resources.limits.cpu"
    value = "100m"
  }
  set {
    name  = "resources.limits.memory"
    value = "200Mi"
  }
  set {
    name  = "resources.requests.cpu"
    value = "100m"
  }
  set {
    name  = "resources.requests.memory"
    value = "200Mi"
  }
  */
  

}