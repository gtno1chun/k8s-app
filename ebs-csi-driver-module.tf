module "ebs_csi_driver_controller" {
  source = "DrFaust92/ebs-csi-driver/kubernetes"
  version = "2.12.0"

  # ebs_csi_controller_image                   = ""
  # ebs_csi_controller_role_name               = "ebs-csi-driver-controller"
  # ebs_csi_controller_role_policy_name_prefix = "ebs-csi-driver-policy"
  # oidc_url                                   = aws_iam_openid_connect_provider.openid_connect.url
  ebs_csi_controller_image                   = ""
  ebs_csi_controller_role_name               = "AmazonEKS_EBS_CSI_DriverRole"
  ebs_csi_controller_role_policy_name_prefix = "AmazonEKS_EBS_CSI_Driver_Policy"
  oidc_url                                   = aws_iam_openid_connect_provider.openid_connect.url
}

