#####################################
###### spinnaker s3 access Role #####
#####################################
locals {
  bucket-name         = aws_s3_bucket.s3_artifacts.bucket
  # bucket-name-kayenta = aws_s3_bucket.s3_storage.bucket  
}

resource "aws_iam_role" "amazoneks_spinnaker_s3_role" {
  name    = "spinnaker-s3" 

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::481230465846:user/vaultcloud-user"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${aws_iam_openid_connect_provider.openid_connect.arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "${aws_iam_openid_connect_provider.openid_connect.url}:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_policy" "amazoneks_spinnaker_s3_policy" {
  name        = aws_iam_role.amazoneks_spinnaker_s3_role.name
  path        = "/"
  description = "spinnacker s3 access role" 

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListObjectsInBucket",
            "Effect": "Allow",
            "Action": ["s3:ListBucket"],
            "Resource": [
              "arn:aws:s3:::${local.bucket-name}"
            ]
               
        },
        {
            "Sid": "AllObjectActions",
            "Effect": "Allow",
            "Action": "s3:*Object",
            "Resource": [
              "arn:aws:s3:::${local.bucket-name}/*"
            ]
        }
    ]
}
EOF
}


# resource "aws_iam_policy" "amazoneks_spinnaker_s3_policy" {
#   name        = aws_iam_role.amazoneks_spinnaker_s3_role.name
#   path        = "/"
#   description = "spinnacker s3 access role" 

#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "ListObjectsInBucket",
#             "Effect": "Allow",
#             "Action": ["s3:ListBucket"],
#             "Resource": [
#               "arn:aws:s3:::${local.bucket-name}",
#               "arn:aws:s3:::${local.bucket-name-kayenta}"
#             ]
               
#         },
#         {
#             "Sid": "AllObjectActions",
#             "Effect": "Allow",
#             "Action": "s3:*Object",
#             "Resource": [
#               "arn:aws:s3:::${local.bucket-name}/*",
#               "arn:aws:s3:::${local.bucket-name-kayenta}/*"
#             ]
#         }
#     ]
# }
# EOF
# }

resource "aws_iam_role_policy_attachment" "amazoneks_spinnaker_s3_role_policy_attach" {
  role        = aws_iam_role.amazoneks_spinnaker_s3_role.name
  policy_arn  = aws_iam_policy.amazoneks_spinnaker_s3_policy.arn
}

output "spinnaker_s3_role_arn" {
  value   = aws_iam_role.amazoneks_spinnaker_s3_role.arn
}
