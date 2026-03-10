resource "authentik_provider_oauth2" "this" {
  name               = var.name
  authorization_flow = var.authorization_flow
  invalidation_flow  = var.invalidation_flow
  client_id          = var.client_id
  client_type        = var.client_type

  client_secret           = var.client_secret != "" ? var.client_secret : null
  include_claims_in_id_token = var.include_claims_in_id_token
  issuer_mode             = var.issuer_mode
  sub_mode                = var.sub_mode
  access_code_validity    = var.access_code_validity
  access_token_validity   = var.access_token_validity
  refresh_token_validity  = var.refresh_token_validity

  authentication_flow = var.authentication_flow != "" ? var.authentication_flow : null
  signing_key         = var.signing_key != "" ? var.signing_key : null
  encryption_key      = var.encryption_key != "" ? var.encryption_key : null
  logout_method       = var.logout_method != "" ? var.logout_method : null
  logout_uri          = var.logout_uri != "" ? var.logout_uri : null

  allowed_redirect_uris = length(var.allowed_redirect_uris) > 0 ? var.allowed_redirect_uris : null
  property_mappings     = length(var.property_mappings) > 0 ? var.property_mappings : null
  jwks_sources          = length(var.jwks_sources) > 0 ? var.jwks_sources : null
}
