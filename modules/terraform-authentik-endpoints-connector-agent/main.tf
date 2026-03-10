resource "authentik_endpoints_connector_agent" "this" {
  name = var.name

  enabled                          = var.enabled
  authorization_flow               = var.authorization_flow != "" ? var.authorization_flow : null
  auth_session_duration            = var.auth_session_duration != "" ? var.auth_session_duration : null
  auth_terminate_session_on_expiry = var.auth_terminate_session_on_expiry
  challenge_idle_timeout           = var.challenge_idle_timeout != "" ? var.challenge_idle_timeout : null
  challenge_key                    = var.challenge_key != "" ? var.challenge_key : null
  challenge_trigger_check_in       = var.challenge_trigger_check_in
  refresh_interval                 = var.refresh_interval != "" ? var.refresh_interval : null
  snapshot_expiry                  = var.snapshot_expiry != "" ? var.snapshot_expiry : null
  nss_uid_offset                   = var.nss_uid_offset
  nss_gid_offset                   = var.nss_gid_offset
  jwt_federation_providers         = length(var.jwt_federation_providers) > 0 ? var.jwt_federation_providers : null
}
