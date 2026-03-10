resource "authentik_stage_authenticator_duo" "this" {
  name            = var.name
  client_id       = var.client_id
  client_secret   = var.client_secret
  api_hostname    = var.api_hostname

  configure_flow              = var.configure_flow != "" ? var.configure_flow : null
  friendly_name               = var.friendly_name != "" ? var.friendly_name : null
  admin_integration_key       = var.admin_integration_key != "" ? var.admin_integration_key : null
  admin_secret_key            = var.admin_secret_key != "" ? var.admin_secret_key : null
}
