resource "authentik_source_saml" "this" {
  name                    = var.name
  slug                    = var.slug
  sso_url                 = var.sso_url
  pre_authentication_flow = var.pre_authentication_flow

  enabled  = var.enabled
  promoted = var.promoted

  authentication_flow = var.authentication_flow != "" ? var.authentication_flow : null
  enrollment_flow     = var.enrollment_flow != "" ? var.enrollment_flow : null
  policy_engine_mode  = var.policy_engine_mode != "" ? var.policy_engine_mode : null
  user_matching_mode  = var.user_matching_mode != "" ? var.user_matching_mode : null
  group_matching_mode = var.group_matching_mode != "" ? var.group_matching_mode : null
  user_path_template  = var.user_path_template != "" ? var.user_path_template : null

  issuer              = var.issuer != "" ? var.issuer : null
  slo_url             = var.slo_url != "" ? var.slo_url : null
  binding_type        = var.binding_type != "" ? var.binding_type : null
  name_id_policy      = var.name_id_policy != "" ? var.name_id_policy : null
  digest_algorithm    = var.digest_algorithm != "" ? var.digest_algorithm : null
  signature_algorithm = var.signature_algorithm != "" ? var.signature_algorithm : null
  signing_kp          = var.signing_kp != "" ? var.signing_kp : null
  verification_kp     = var.verification_kp != "" ? var.verification_kp : null
  encryption_kp       = var.encryption_kp != "" ? var.encryption_kp : null

  allow_idp_initiated          = var.allow_idp_initiated
  signed_assertion             = var.signed_assertion
  signed_response              = var.signed_response
  temporary_user_delete_after  = var.temporary_user_delete_after != "" ? var.temporary_user_delete_after : null

  property_mappings       = length(var.property_mappings) > 0 ? var.property_mappings : null
  property_mappings_group = length(var.property_mappings_group) > 0 ? var.property_mappings_group : null
}
