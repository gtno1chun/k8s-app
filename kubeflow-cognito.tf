data "kustomization" "test" {
  provider = kustomization
  path = "test_kustomization/basic/initial"

}
resource "kustomization_resource" "test" {
  provider = kustomization
  for_each = data.kustomization.test.ids
  manifest = data.kustomization.test.manifests[each.value]
}

output test-provider {
  value = data.kustomization.test.ids

}
output "test-manifest" {
  value = data.kustomization.test.manifests[each.value]
} 
  