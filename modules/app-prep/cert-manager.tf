resource "helm_release" "cert_manager" {
  count             = 1
  name              = "cert-manager"
  chart             = "cert-manager"
  repository        = "https://charts.jetstack.io"
  dependency_update = true
  namespace         = "cert-manager"
  timeout           = var.helm_timeout_unit * 3
  atomic            = var.helm_atomic
  version           = "v1.9.0"
  depends_on = [
    helm_release.namespaces[0]
  ]

  set {
    name  = "installCRDs"
    value = true
  }
}
