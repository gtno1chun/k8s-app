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
  value = kustomization_resource.test.for_each

}
output "test-manifest" {
  value = kustomization_resource.test.manifest
} 
  