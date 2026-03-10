resource "authentik_source_oauth" "this" {
  name          = var.name
  slug          = var.slug
  provider_type = var.provider_type
  consumer_key  = var.consumer_key

  consumer_secret = var.consumer_secret
  enabled         = var.enabled
  promoted        = var.promoted

  authentication_flow            = var.authentication_flow != "" ? var.authentication_flow : null
  enrollment_flow                = var.enrollment_flow != "" ? var.enrollment_flow : null
  policy_engine_mode             = var.policy_engine_mode != "" ? var.policy_engine_mode : null
  user_matching_mode             = var.user_matching_mode != "" ? var.user_matching_mode : null
  group_matching_mode            = var.group_matching_mode != "" ? var.group_matching_mode : null
  user_path_template             = var.user_path_template != "" ? var.user_path_template : null
  authorization_code_auth_method = var.authorization_code_auth_method != "" ? var.authorization_code_auth_method : null
  pkce                           = var.pkce != "" ? var.pkce : null

  oidc_well_known_url = var.oidc_well_known_url != "" ? var.oidc_well_known_url : null
  oidc_jwks_url       = var.oidc_jwks_url != "" ? var.oidc_jwks_url : null
  oidc_jwks           = var.oidc_jwks != "" ? var.oidc_jwks : null
  authorization_url   = var.authorization_url != "" ? var.authorization_url : null
  access_token_url    = var.access_token_url != "" ? var.access_token_url : null
  profile_url         = var.profile_url != "" ? var.profile_url : null
  request_token_url   = var.request_token_url != "" ? var.request_token_url : null
  additional_scopes   = var.additional_scopes != "" ? var.additional_scopes : null

  property_mappings       = length(var.property_mappings) > 0 ? var.property_mappings : null
  property_mappings_group = length(var.property_mappings_group) > 0 ? var.property_mappings_group : null
}
