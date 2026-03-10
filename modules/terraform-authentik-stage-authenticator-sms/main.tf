resource "authentik_stage_authenticator_sms" "this" {
  name            = var.name
  account_sid     = var.account_sid
  auth            = var.auth
  from_number     = var.from_number

  configure_flow              = var.configure_flow != "" ? var.configure_flow : null
  friendly_name               = var.friendly_name != "" ? var.friendly_name : null
  sms_provider                = var.sms_provider != "" ? var.sms_provider : null
  auth_type                   = var.auth_type != "" ? var.auth_type : null
  auth_password               = var.auth_password != "" ? var.auth_password : null
  mapping                     = var.mapping != "" ? var.mapping : null
  verify_only                 = var.verify_only
}
