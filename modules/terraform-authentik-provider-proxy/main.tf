resource "authentik_provider_proxy" "this" {
  name               = var.name
  authorization_flow = var.authorization_flow
  invalidation_flow  = var.invalidation_flow
  external_host      = var.external_host

  internal_host                = var.internal_host != "" ? var.internal_host : null
  internal_host_ssl_validation = var.internal_host_ssl_validation
  mode                         = var.mode != "" ? var.mode : null
  authentication_flow          = var.authentication_flow != "" ? var.authentication_flow : null
  cookie_domain                = var.cookie_domain != "" ? var.cookie_domain : null
  access_token_validity        = var.access_token_validity != "" ? var.access_token_validity : null
  refresh_token_validity       = var.refresh_token_validity != "" ? var.refresh_token_validity : null
  skip_path_regex              = var.skip_path_regex != "" ? var.skip_path_regex : null
  basic_auth_enabled           = var.basic_auth_enabled
  basic_auth_username_attribute = var.basic_auth_username_attribute != "" ? var.basic_auth_username_attribute : null
  basic_auth_password_attribute = var.basic_auth_password_attribute != "" ? var.basic_auth_password_attribute : null
  intercept_header_auth        = var.intercept_header_auth

  property_mappings = length(var.property_mappings) > 0 ? var.property_mappings : null
  jwks_sources      = length(var.jwks_sources) > 0 ? var.jwks_sources : null
}
