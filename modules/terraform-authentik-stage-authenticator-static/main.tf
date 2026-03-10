resource "authentik_stage_authenticator_static" "this" {
  name            = var.name

  configure_flow              = var.configure_flow != "" ? var.configure_flow : null
  friendly_name               = var.friendly_name != "" ? var.friendly_name : null
  token_count                 = var.token_count
  token_length                = var.token_length
}
