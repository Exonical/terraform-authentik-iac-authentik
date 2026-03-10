resource "authentik_policy_expression" "this" {
  name       = var.name
  expression = var.expression

  execution_logging = var.execution_logging
}
