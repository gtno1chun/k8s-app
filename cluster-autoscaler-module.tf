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
