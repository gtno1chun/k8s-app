
# output "kubernetes_host" {
#   description  = "k8s eks host" 
#   value        = data.terraform_remote_state.cluster.outputs.kubernetes_host
# }
# output "kubernetes_cluster_ca_certificate" {
#   description = "k8s eks certificate"
#   value       = data.terraform_remote_state.cluster.outputs.kubernetes_cluster_ca_certificate

# }
# output "kubernetes_token" {
#   description = "k8s eks token"  
#   value       = data.terraform_remote_state.cluster.outputs.kubernetes_token 
#   sensitive   = true
# }

output "eks-version" {
  description   = "aws_eks_cluster_identity cluster version"
  value         = data.aws_eks_cluster.cluster.version 
}


