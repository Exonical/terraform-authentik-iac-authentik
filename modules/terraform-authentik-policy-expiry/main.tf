resource "authentik_policy_expiry" "this" {
  name = var.name
  days = var.days

  execution_logging = var.execution_logging
  deny_only         = var.deny_only
}
