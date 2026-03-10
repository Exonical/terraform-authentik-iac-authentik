resource "authentik_source_plex" "this" {
  name       = var.name
  slug       = var.slug
  client_id  = var.client_id
  plex_token = var.plex_token

  enabled  = var.enabled
  promoted = var.promoted

  allow_friends       = var.allow_friends
  authentication_flow = var.authentication_flow != "" ? var.authentication_flow : null
  enrollment_flow     = var.enrollment_flow != "" ? var.enrollment_flow : null
  policy_engine_mode  = var.policy_engine_mode != "" ? var.policy_engine_mode : null
  user_matching_mode  = var.user_matching_mode != "" ? var.user_matching_mode : null
  group_matching_mode = var.group_matching_mode != "" ? var.group_matching_mode : null
  user_path_template  = var.user_path_template != "" ? var.user_path_template : null

  allowed_servers = length(var.allowed_servers) > 0 ? var.allowed_servers : null
}
