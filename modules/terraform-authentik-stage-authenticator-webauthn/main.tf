resource "authentik_stage_authenticator_webauthn" "this" {
  name            = var.name

  configure_flow              = var.configure_flow != "" ? var.configure_flow : null
  friendly_name               = var.friendly_name != "" ? var.friendly_name : null
  user_verification           = var.user_verification != "" ? var.user_verification : null
  resident_key_requirement    = var.resident_key_requirement != "" ? var.resident_key_requirement : null
  authenticator_attachment    = var.authenticator_attachment != "" ? var.authenticator_attachment : null
  device_type_restrictions    = length(var.device_type_restrictions) > 0 ? var.device_type_restrictions : null
  max_attempts                = var.max_attempts
}
