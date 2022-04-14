# module "cluster_autoscaler" {
#   source = "git::https://github.com/DNXLabs/terraform-aws-eks-cluster-autoscaler.git"

#   enabled = true

#   # cluster_name                     = module.eks_cluster.cluster_id
#   # cluster_identity_oidc_issuer     = module.eks_cluster.cluster_oidc_issuer_url
#   # cluster_identity_oidc_issuer_arn = module.eks_cluster.oidc_provider_arn
#   # aws_region                       = data.aws_region.current.name
#   cluster_name                     = local.cluster_name
#   cluster_identity_oidc_issuer     = aws_iam_openid_connect_provider.openid_connect.url
#   cluster_identity_oidc_issuer_arn = aws_iam_openid_connect_provider.openid_connect.arn
#   aws_region                       = local.region
# }

locals {
  iam-cluster-autoscaler  = aws_iam_role.amazoneks_cluster_autoscaler_role.name

}

resource "helm_release" "cluster-autoscaler" {

  name      = "cluster-autoscaler"
  namespace = "kube-system"
  chart     = "cluster-autoscaler"
  version   = "9.17.0"

  # moved this chart
  repository = "https://kubernetes.github.io/autoscaler"

  recreate_pods = true

  values = [
    file("helm/charts/cluster-autoscaler/values.yaml")
  ]

  set {
    name  = "image.tag"
    value = "v1.23.0"
  }
  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = local.cluster_name
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "rbac.pspEnabled"
    value = "false"
  }
  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "arn:aws:iam::481230465846:role/${local.iam-cluster-autoscaler}"
  }
  sert {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "awsRegion"
    value = local.aws_region
  }

  set {
    name  = "serviceMonitor.enabled"
    value = "true"
  }

  set {
    name  = "serviceMonitor.namespace"
    value = "prometheus"
  }

  set {
    name  = "replicaCount"
    value = 2
  }

  timeout = 350
}
