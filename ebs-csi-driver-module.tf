# module "ebs_csi_driver_controller" {
#   source = "DrFaust92/ebs-csi-driver/kubernetes"
#   version = "2.12.0"

#   # ebs_csi_controller_image                   = ""
#   # ebs_csi_controller_role_name               = "ebs-csi-driver-controller"
#   # ebs_csi_controller_role_policy_name_prefix = "ebs-csi-driver-policy"
#   # oidc_url                                   = aws_iam_openid_connect_provider.openid_connect.url
#   ebs_csi_controller_image                   = ""
#   ebs_csi_controller_role_name               = "AmazonEKS_EBS_CSI_DriverRole"
#   ebs_csi_controller_role_policy_name_prefix = "AmazonEKS_EBS_CSI_Driver_Policy"
#   oidc_url                                   = aws_iam_openid_connect_provider.openid_connect.url
# }

resource "helm_release" "ebs_csi_controller" {
  name        = "aws-ebs-csi-driver" 
  namespace   = "kube-system"
  chart       = "aws-ebs-csi-driver" 
  version     = "2.6.1"
  repository  = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"

  set {
    name  = "nameOverride"
    value = "ebs-csi-controller" 
  }
  set {
    name  = "fullnameOverride"
    value = "ebs-csi-controller"  
  }
  set {
    name  = "controller.serviceAccount.annotations"
    value = "arn:aws:iam::481230465846:role/AmazonEKS_EBS_CSI_DriverRole"
  }

#   set {
#     name  = "storageClasses"
#     value = ""

#   }

#   values = [
#     file("./helm/values/default-affinity-node.yaml"),
#     <<-VALUES
# storageClasses:
#   - name: gp3
#     annotations:
#       storageclass.kubernetes.io/is-default-class: "true"
#     labels:
#       managedby: k8s-terraform
#     volumeBindingMode: WaitForFirstConsumer
#     reclaimPolicy: Delete
#   VALUES
#   ]

}