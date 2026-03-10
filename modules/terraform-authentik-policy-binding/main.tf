resource "authentik_policy_binding" "this" {
  target = var.target
  order  = var.order

  policy         = var.policy != "" ? var.policy : null
  group          = var.group != "" ? var.group : null
  user           = var.user != 0 ? var.user : null
  enabled        = var.enabled
  negate         = var.negate
  timeout        = var.timeout
  failure_result = var.failure_result
}
