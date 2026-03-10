resource "authentik_stage_authenticator_email" "this" {
  name            = var.name

  configure_flow              = var.configure_flow != "" ? var.configure_flow : null
  friendly_name               = var.friendly_name != "" ? var.friendly_name : null
  from_address                = var.from_address != "" ? var.from_address : null
  host                        = var.host != "" ? var.host : null
  username                    = var.username != "" ? var.username : null
  password                    = var.password != "" ? var.password : null
  subject                     = var.subject != "" ? var.subject : null
  template                    = var.template != "" ? var.template : null
  token_expiry                = var.token_expiry != "" ? var.token_expiry : null
  use_global_settings         = var.use_global_settings
  use_ssl                     = var.use_ssl
  use_tls                     = var.use_tls
  port                        = var.port
  timeout                     = var.timeout
}
