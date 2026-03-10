resource "authentik_provider_saml" "this" {
  name               = var.name
  authorization_flow = var.authorization_flow
  invalidation_flow  = var.invalidation_flow
  acs_url            = var.acs_url

  assertion_valid_not_before      = var.assertion_valid_not_before
  assertion_valid_not_on_or_after = var.assertion_valid_not_on_or_after
  session_valid_not_on_or_after   = var.session_valid_not_on_or_after
  digest_algorithm                = var.digest_algorithm
  signature_algorithm             = var.signature_algorithm

  audience              = var.audience != "" ? var.audience : null
  issuer                = var.issuer != "" ? var.issuer : null
  authentication_flow   = var.authentication_flow != "" ? var.authentication_flow : null
  sp_binding            = var.sp_binding != "" ? var.sp_binding : null
  signing_kp            = var.signing_kp != "" ? var.signing_kp : null
  verification_kp       = var.verification_kp != "" ? var.verification_kp : null
  encryption_kp         = var.encryption_kp != "" ? var.encryption_kp : null
  name_id_mapping       = var.name_id_mapping != "" ? var.name_id_mapping : null
  default_relay_state   = var.default_relay_state != "" ? var.default_relay_state : null
  sls_url               = var.sls_url != "" ? var.sls_url : null
  sls_binding           = var.sls_binding != "" ? var.sls_binding : null
  logout_method         = var.logout_method != "" ? var.logout_method : null

  sign_assertion     = var.sign_assertion
  sign_response      = var.sign_response
  sign_logout_request = var.sign_logout_request

  property_mappings = length(var.property_mappings) > 0 ? var.property_mappings : null
}
