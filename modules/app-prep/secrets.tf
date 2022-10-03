resource "helm_release" "secrets" {
  count             = 1
  name              = "secrets"
  chart             = "${var.project_root_path}/secrets"
  dependency_update = true
  atomic            = true

  depends_on = [
    helm_release.namespaces[0]
  ]
}
