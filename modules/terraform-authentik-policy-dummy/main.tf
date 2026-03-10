resource "authentik_policy_dummy" "this" {
  name = var.name

  execution_logging = var.execution_logging
  result            = var.result
  wait_min          = var.wait_min
  wait_max          = var.wait_max
}
