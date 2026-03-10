resource "authentik_policy_password" "this" {
  name          = var.name
  error_message = var.error_message

  execution_logging        = var.execution_logging
  length_min               = var.length_min
  amount_digits            = var.amount_digits
  amount_uppercase         = var.amount_uppercase
  amount_lowercase         = var.amount_lowercase
  amount_symbols           = var.amount_symbols
  symbol_charset           = var.symbol_charset != "" ? var.symbol_charset : null
  password_field           = var.password_field != "" ? var.password_field : null
  check_static_rules       = var.check_static_rules
  check_have_i_been_pwned  = var.check_have_i_been_pwned
  check_zxcvbn             = var.check_zxcvbn
  hibp_allowed_count       = var.hibp_allowed_count
  zxcvbn_score_threshold   = var.zxcvbn_score_threshold
}
