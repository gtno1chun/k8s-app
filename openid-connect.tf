data "tls_certificate" "cert" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "openid_connect" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cert.certificates.0.sha1_fingerprint]
  url             = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

output "openid_web_url" {
  description   = "oidc address"
  value         = data.tls_certificate.cert.url
} 

output "oidc_thumpprint_list" {
  value   = [data.tls_certificate.cert.certificates.0.sha1_fingerprint] 
}

output "openid_url" {
  value  = aws_iam_openid_connect_provider.openid_connect.url
}
output "openid_arn" {
  value = aws_iam_openid_connect_provider.openid_connect.arn

}