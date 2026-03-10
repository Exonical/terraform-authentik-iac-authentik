resource "authentik_stage_email" "this" {
  name            = var.name

  from_address                = var.from_address != "" ? var.from_address : null
  host                        = var.host != "" ? var.host : null
  username                    = var.username != "" ? var.username : null
  password                    = var.password != "" ? var.password : null
  subject                     = var.subject != "" ? var.subject : null
  template                    = var.template != "" ? var.template : null
  token_expiry                = var.token_expiry != "" ? var.token_expiry : null
  recovery_cache_timeout      = var.recovery_cache_timeout != "" ? var.recovery_cache_timeout : null
  use_global_settings         = var.use_global_settings
  use_ssl                     = var.use_ssl
  use_tls                     = var.use_tls
  activate_user_on_success    = var.activate_user_on_success
  port                        = var.port
  timeout                     = var.timeout
  recovery_max_attempts       = var.recovery_max_attempts
}
