resource "authentik_stage_mutual_tls" "this" {
  name            = var.name

  mode                        = var.mode != "" ? var.mode : null
  cert_attribute              = var.cert_attribute != "" ? var.cert_attribute : null
  user_attribute              = var.user_attribute != "" ? var.user_attribute : null
  certificate_authorities     = length(var.certificate_authorities) > 0 ? var.certificate_authorities : null
}
