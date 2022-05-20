
# provider "aws" {
#   region = local.region
# } 

data "terraform_remote_state" "cluster" {
  backend = "remote"

  config = {
    # hostname     = "app.terraform.io/app"
    organization = "jackchun"
    workspaces = {
      name = var.cluster_workspace
    }
  }
}

data "aws_eks_cluster" "cluster" {
  # count = local.create_eks ? 1 : 0
  # name  = module.eks.cluster_id
  name  = data.terraform_remote_state.cluster.outputs.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  # count = local.create_eks ? 1 : 0
  # name  = module.eks.cluster_id
  name  = data.terraform_remote_state.cluster.outputs.eks_cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token 
  }
}

# provider "vault" {
#   address   = var.vault_endpoint
# }

provider "vault" {
  # address = var.vault_endpoint
  address = data.terraform_remote_state.cluster.outputs.vault_endpoint 
  auth_login {
    path = format("auth/userpass/login/%s", data.terraform_remote_state.cluster.outputs.vault_username)
    parameters = {
      # username = var.username_vault
      # password = var.password_vault 
      username = data.terraform_remote_state.cluster.outputs.vault_username
      password = data.terraform_remote_state.cluster.outputs.vault_password 
    }
  }
} 

data "vault_aws_access_credentials" "vault-assume" {
  backend = "aws"
  role    = "eks-tfc-role"
  #role_arn = "arn:aws:iam::481230465846:role/TerraformCloud"
  type    = "sts"
}

# data "vault_aws_access_credentials" "vault-assume" {
#   backend = "aws-eks"
#   role    = "user-tfc"
#   type    = "sts"
# }


provider "aws" {
  region     = "ap-northeast-2"
  access_key = data.vault_aws_access_credentials.vault-assume.access_key
  secret_key = data.vault_aws_access_credentials.vault-assume.secret_key
  token      = data.vault_aws_access_credentials.vault-assume.security_token
}

terraform {
  required_providers {
    kustomization = {
      source  = "kbst/kustomization"
      version = "v0.2.0-beta.3"
    }
  }
  required_version = ">= 0.12"
}
provider "kustomization" {}