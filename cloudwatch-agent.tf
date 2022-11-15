resource "kubernetes_namespace" "aws-cloudwatch_ns" {
  metadata {
    annotations = {
      name = "aws-cloudwatch"
    }
    labels = {
      role = "aws-cloudwatch"
    }
    name = "aws-cloudwatch"
  }
}


resource "helm_release" "cloudwatch-agent" {
  depends_on = [
    kubernetes_namespace.cloudwatch_ns,
    #helm_release.ebs-csi-controller,
  ]

  repository    = "https://aws.github.io/eks-charts"
  chart         = "aws-cloudwatch-metrics"  
  version       = "0.0.7" 
  name          = "aws-cloudwatch-metrics" 
  namespace     = kubernetes_namespace.aws-cloudwatch_ns.name


 /* 
  #recreate_pods = true
  values = [ 
    file("./helm/charts/cloudwatch-agent/values.yaml")
  ]
  
  
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