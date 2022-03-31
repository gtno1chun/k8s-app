

resource "aws_iam_user" "ecr_user" {

  name          = "eks-prod-ecr" 
  path          = "/"

  tags = {
    owner = "jackchun@mz.co.kr"
    purpose = "circle ci context: eks-prod-context"
    managedby = "terraform"
    SEC_ASSETS_ACCESS_KEY = "SERVICE"
  }
}

resource "aws_iam_access_key" "ecr_user_credential" {
  user  = aws_iam_user.ecr_user.name
}

/*resource "aws_iam_access_key" "ecr_user_credential_second" {
  user  = aws_iam_user.ecr_user.name
}*/

/*resource "aws_iam_user_policy_attachment" "AmazonEC2ContainerRegistryFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  user       = aws_iam_user.ecr_user.name
}*/

output "access_key" {
  value = aws_iam_access_key.ecr_user_credential.id 
}

output "secret" {
  value = aws_iam_access_key.ecr_user_credential.secret
}

/*output "access_key_second" {
  value = aws_iam_access_key.ecr_user_credential_second.id
}

output "secret_second" {
  value = aws_iam_access_key.ecr_user_credential_second.secret
}*/

data "aws_iam_policy_document" "ecr_user_policy" {
  statement {
    sid       = "EcrAllowPushImageAtSuwon"
    effect    = "Allow"
    resources = [ "*" ]
    actions   = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchDeleteImage",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:CreateRepository",
      "ecr:DeleteLifecyclePolicy",
      "ecr:DescribeImages",
      "ecr:DescribeImageScanFindings",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetLifecyclePolicy",
      "ecr:GetRepositoryPolicy",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
      "ecr:PutImage",
      "ecr:PutLifecyclePolicy",
      "ecr:UploadLayerPart",
    ]
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = [
        "210.94.41.88/32",
        "210.94.41.89/32"
      ]
    }
  }
}

resource "aws_iam_policy" "ecr_user_policy" {
  name        = "EcrAllowPushImageAtSuwon"
  description = "allow rule in order to push image to ecr at suwon"
  policy      = data.aws_iam_policy_document.ecr_user_policy.json
  path        = "/"
}

resource "aws_iam_user_policy_attachment" "ecr_user_policy" {
  policy_arn = aws_iam_policy.ecr_user_policy.arn
  user       = aws_iam_user.ecr_user.name
}


/*
####################################################
# SCLOUD-53570 요청
####################################################
data "aws_iam_policy_document" "ecr_user_iam_policy" {
  statement {
    sid = "NotIpAddress"
    actions   = [
      "*"
    ]
    resources = ["*"]
    effect    = "Deny"

    condition {
      test     = "NotIpAddress"
      variable = "aws:sourceIp"

      values = [
          "210.94.41.88/32",
          "210.94.41.89/32"        
      ]
    }
  }
}

resource "aws_iam_user_policy" "aws_iam_user_policy_deny" {
  name   = format("%s-%s", aws_iam_user.ecr_user.name, "Deny")   
  user   = aws_iam_user.ecr_user.name
  policy = data.aws_iam_policy_document.ecr_user_iam_policy.json
}
*/
