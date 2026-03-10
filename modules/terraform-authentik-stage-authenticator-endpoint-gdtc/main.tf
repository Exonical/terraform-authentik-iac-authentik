resource "authentik_stage_authenticator_endpoint_gdtc" "this" {
  name            = var.name
  credentials     = var.credentials

  configure_flow              = var.configure_flow != "" ? var.configure_flow : null
  friendly_name               = var.friendly_name != "" ? var.friendly_name : null
}
