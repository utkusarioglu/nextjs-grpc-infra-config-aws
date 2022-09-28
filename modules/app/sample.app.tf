resource "helm_release" "sample" {
  name              = "sample"
  chart             = "../../configs/sample/helm"
  dependency_update = true
  atomic            = true

  set {
    name  = "ingress.securityGroup"
    value = var.aws_alb_security_group_id
  }

  // TODO this is not a good place for this action
  // this release may not be the only one that uses this lb
  // it's an antipattern to have this here
  provisioner "local-exec" {
    when       = destroy
    command    = "scripts/aws-delete-load-balancer.sh"
    on_failure = fail
  }
}
