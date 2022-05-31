# variable "security_group_id" {}

# data "aws_security_group" "selected" {
#   id = var.security_group_id
# }
# output "security_group_id" {
#   description = "sgr-id"
#   value = data.aws_security_group.selected.id
  
# }

data "aws_security_groups" "test" {
  tags = {
    Name = "eks-cluster-sg-jackchun-eks-oazw-1444394879"
  }
}

output "security_group_id" {
  description = "sgr-id"
  value = data.aws_security_groups.test.id
  
}
output "security_group_arn" {
  description = "sgr-id"
  value = data.aws_security_groups.test.arn
  
}
output "security_group_ids" {
  description = "sgr-id"
  value = data.aws_security_groups.test.ids
  
}
output "security_group_vpc_ids" {
  description = "sgr-id"
  value = data.aws_security_groups.test.vpc_ids
  
}