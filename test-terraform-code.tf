# variable "security_group_id" {}

# data "aws_security_group" "selected" {
#   id = var.security_group_id
# }
# output "security_group_id" {
#   description = "sgr-id"
#   value = data.aws_security_group.selected.id
  
# }

# data "aws_security_groups" "test" {
#   tags = {
#     Name = "eks-cluster-sg-jackchun-eks-oazw-1444394879"
#   }
# }

# data "aws_security_groups" "test" {
#   filter {
#     name = "group-name"
#     values = ["*Ubuntu*"]
#   }
# }


# output "security_group_id" {
#   description = "sgr-id"
#   value = data.aws_security_groups.test.id
  
# }
# output "security_group_arns" {
#   description = "sgr-id"
#   value = data.aws_security_groups.test.arns
  
# }
# output "security_group_ids" {
#   description = "sgr-id"
#   value = data.aws_security_groups.test.ids
  
# }
# output "security_group_vpc_ids" {
#   description = "sgr-id"
#   value = data.aws_security_groups.test.vpc_ids
  
# }


variable "roles" {
  #type = map(list(string))
  default = {
    dev = {
      "file" = ["file", "file-batch", "mex", "filemeta", "filemeta-batch", "cdjava"]
      "dpl"  = ["dpl"]
      "media" = ["samsungnotes-batch"]
      "odigw" = ["odi-batch"]
    }
    stg = {
      "file" = ["file", "file-batch", "mex", "filemeta", "filemeta-batch", "cdjava"]
      "dpl"  = ["dpl"]
      "media" = ["samsungnotes-batch"]
      "odigw" = ["odi-batch"]
    }
    prod = {
      "file" = ["file", "file-batch", "mex", "filemeta", "filemeta-batch", "cdjava"]
      "dpl"  = ["dpl"]
      "media" = ["samsungnotes-batch"]
      "odigw" = ["odi-batch"]
    }
    prod-cn = {
    }
  }
}


output "test-01" {
  description = ""
  value = map(var.roles.stg[*])

}
# locals {

#   roles_flat = flatten([
#     for name, namespaces in var.roles.stg : [
#       for namespace in namespaces : {
#         name      = name,
#         namespace = namespace,
#       }
#     ]
#   ])


# }


