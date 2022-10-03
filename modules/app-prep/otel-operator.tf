resource "helm_release" "otel_operator" {
  count             = 1
  name              = "otel-operator"
  chart             = "${var.project_root_path}/otel-operator"
  dependency_update = true
  atomic            = var.helm_atomic
  namespace         = "observability"
  timeout           = var.helm_timeout_unit * 3

  depends_on = [
    helm_release.cert_manager[0]
  ]
}
