resource "authentik_stage_authenticator_totp" "this" {
  name            = var.name

  configure_flow              = var.configure_flow != "" ? var.configure_flow : null
  friendly_name               = var.friendly_name != "" ? var.friendly_name : null
  digits                      = var.digits != "" ? var.digits : null
}
