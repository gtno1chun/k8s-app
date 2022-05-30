variable "cluster_workspace" {
  default = ""
}

### apply vault we don't need aws access key and secret key 
# variable "AWS_ACCESS_KEY_ID" {
#   default     = "aws access keyu"
# }
# variable "AWS_SECRET_ACCESS_KEY" {
#   default     = "aws secret key"
# }

### apply vault info -> using my-k8s outputs 
# variable "vault_endpoint" {
#   default = ""
# }
# variable "VAULT_TOKEN" {
#   description = "vault access Token : https://registry.terraform.io/providers/hashicorp/vault/latest/docs#token" 
#   sensitive   = true 
# } 
