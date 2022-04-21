locals {
  cluster_name            = data.terraform_remote_state.cluster.outputs.eks_cluster_id
  cluster_version         = data.aws_eks_cluster.cluster.version
  region                  = "ap-northeast-2"
  aws_region              = "ap-northeast-2" 
}

output "cluster_name" {
  description = "cluster name"
  value       = local.cluster_name 
}