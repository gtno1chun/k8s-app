resource "kubernetes_namespace" "spinnaker_ns" {
  metadata {
    annotations = {
      name = "spinnaker" 
    }
    labels = {
      role = "spinnaker-role" 
    }
    name = "spinnaker" 
  }
}

resource "kubernetes_service_account" "spinnaker_sa" {

  depends_on = [kubernetes_namespace.spinnaker_ns]

  metadata {
    name      = "spinnaker-service-account"
    namespace = "spinnaker"
  }
}


resource "kubernetes_cluster_role" "spinnaker-role" {
  metadata {
    name = "spinnaker-role"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces", "configmaps", "events", "replicationcontrollers", "serviceaccounts", "pods/log"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "secrets"]
    verbs      = ["create", "delete", "deletecollection", "get", "list", "patch", "update", "watch"]
  }
  rule {
    api_groups = ["autoscaling"]
    resources  = ["horizontalpodautoscalers"]
    verbs      = ["create", "delete", "get", "list", "patch", "update"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["controllerrevisions", "statefulsets"]
    verbs      = ["list"]
  }
  rule {
    api_groups = ["extensions", "apps"]
    resources  = ["deployments", "replicasets", "ingresses"]
    verbs      = ["create", "delete", "deletecollection", "get", "list", "patch", "update", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["services/proxy", "pods/portforward"]
    verbs      = ["create", "delete", "deletecollection", "get", "list", "patch", "update", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "spinnaker_rolebinding" {

  depends_on = [
    kubernetes_namespace.spinnaker_ns,
    kubernetes_service_account.spinnaker_sa
  ]

  metadata {
    name = "spinnaker-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "spinnaker-role"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "spinnaker-service-account"
    namespace = "spinnaker"
  }
}