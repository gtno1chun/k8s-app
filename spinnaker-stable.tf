locals {
  
  spinnaker_stable_ns = "spinnaker-stable"
  spinnaker_stable_version                  = "1.20.7"
  spinnaker_stable_halyard_version          = "1.44.1"
  spinnaker_stable_endpoint = "spinnaker"
  spinnaker_stable_gate_endpoint = "spinnaker-gate"
  spinnaker_stable_api_endpoint = "spinnaker-api"
  # spinnaker_stable_s3_assumRole = "arn:aws:iam::481230465846:role/VaultCloud-Role" 
}


## 2022/02/08
resource "aws_s3_bucket" "s3_artifacts" {
  bucket = "s3-spinnaker-artifact"
  acl    = "public-read-write"
  versioning {
    enabled = false
  }
  tags = {
    Name = "s3-spinnaker-artifact"
    Class0 = "Operation"
    Class1 = "Build"
    developer = "vaultcloud-user"
  }
}

# resource "aws_s3_bucket" "s3_storage" {
#   bucket  = "s3-spinnaker-storage-jackchun"  
#   acl     = "public-read-write"
#   versioning {
#     enabled = false
#   }
#   tags = {
#     Name = "s3-spinnaker-storage-jackchun"
#     Class0 = "Operation"
#     Class1 = "Build"
#     developer = "vaultcloud-user"
#   }
# }

# resource "kubernetes_namespace" "spinnaker_stable" {
#   metadata {
#     annotations = {
#       name = "spinnaker"
#     }
#     labels = {
#       role = "spinnaker"
#     }
#     name = local.spinnaker_stable_ns
#   }
# }

# resource "helm_release" "spinnaker_stable" {
#   depends_on    = [
#     kubernetes_namespace.spinnaker_stable, 
#     aws_s3_bucket.s3_artifacts 
#   ]
#   name          = "spinnaker"
#   namespace     = local.spinnaker_stable_ns 
#   repository    = "https://helmcharts.opsmx.com/"
#   chart         = "spinnaker" 
#   recreate_pods = true 

#   #values = [ "${file("./helm/charts/spinnaker/values.yaml")}" ]

#   values = [ templatefile("./helm/charts/spinnaker/values.yaml", {
#     VAULT_TOKEN             = var.VAULT_TOKEN
#     halyard_version         = local.spinnaker_stable_halyard_version
#     version                 = local.spinnaker_stable_version
#     S3-BUCKET-NAME          = aws_s3_bucket.s3_artifacts.bucket
#     REGION                  = "ap-northeast-2"
#     # s3_bucket_access         = data.vault_aws_access_credentials.vault-assume.access_key
#     # s3_bucket_secret         = data.vault_aws_access_credentials.vault-assume.secret_key
#     # role_to_assume          = "arn:aws:iam::481230465846:role/spinnaker-s3" 
#     role_to_assume          = aws_iam_role.amazoneks_spinnaker_s3_role.arn

#     storageclass_name       = "gp2"
    
#   })]
  
#   # force_update = true
#   # wait = false
#   timeout = 600


# }

resource "kubernetes_default_service_account" "spinnaker-default-sa" {
  metadata {
    annotations = {
      "eks.amazonaws.com/role-arn" = "${aws_iam_role.amazoneks_spinnaker_s3_role.arn}"
    }
    namespace = local.spinnaker_stable_ns
  }
  # secret {
  #   name = "${kubernetes_secret.spinnaker-secret.metadata.0.name}"
  # }
}