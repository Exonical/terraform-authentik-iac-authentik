resource "authentik_policy_unique_password" "this" {
  name = var.name

  execution_logging        = var.execution_logging
  num_historical_passwords = var.num_historical_passwords
  password_field           = var.password_field != "" ? var.password_field : null
}
