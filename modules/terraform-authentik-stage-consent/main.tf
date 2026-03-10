resource "authentik_stage_consent" "this" {
  name            = var.name

  mode                        = var.mode != "" ? var.mode : null
  consent_expire_in           = var.consent_expire_in != "" ? var.consent_expire_in : null
}
