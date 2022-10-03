resource "helm_release" "namespaces" {
  count             = 1
  name              = "namespaces"
  chart             = "${var.project_root_path}/namespaces"
  dependency_update = true
  atomic            = true
}
