resource "authentik_stage_authenticator_validate" "this" {
  name            = var.name
  not_configured_action = var.not_configured_action

  last_auth_threshold         = var.last_auth_threshold != "" ? var.last_auth_threshold : null
  webauthn_user_verification  = var.webauthn_user_verification != "" ? var.webauthn_user_verification : null
  configuration_stages        = length(var.configuration_stages) > 0 ? var.configuration_stages : null
  device_classes              = length(var.device_classes) > 0 ? var.device_classes : null
  webauthn_allowed_device_types = length(var.webauthn_allowed_device_types) > 0 ? var.webauthn_allowed_device_types : null
}
