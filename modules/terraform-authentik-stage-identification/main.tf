resource "authentik_stage_identification" "this" {
  name            = var.name

  password_stage              = var.password_stage != "" ? var.password_stage : null
  captcha_stage               = var.captcha_stage != "" ? var.captcha_stage : null
  enrollment_flow             = var.enrollment_flow != "" ? var.enrollment_flow : null
  recovery_flow               = var.recovery_flow != "" ? var.recovery_flow : null
  passwordless_flow           = var.passwordless_flow != "" ? var.passwordless_flow : null
  webauthn_stage              = var.webauthn_stage != "" ? var.webauthn_stage : null
  case_insensitive_matching   = var.case_insensitive_matching
  show_matched_user           = var.show_matched_user
  show_source_labels          = var.show_source_labels
  pretend_user_exists         = var.pretend_user_exists
  enable_remember_me          = var.enable_remember_me
  user_fields                 = length(var.user_fields) > 0 ? var.user_fields : null
  sources                     = length(var.sources) > 0 ? var.sources : null
}
