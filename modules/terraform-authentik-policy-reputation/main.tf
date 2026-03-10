resource "authentik_policy_reputation" "this" {
  name = var.name

  execution_logging = var.execution_logging
  check_ip          = var.check_ip
  check_username    = var.check_username
  threshold         = var.threshold
}
