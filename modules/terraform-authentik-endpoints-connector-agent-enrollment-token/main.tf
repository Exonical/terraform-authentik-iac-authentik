resource "authentik_endpoints_connector_agent_enrollment_token" "this" {
  name      = var.name
  connector = var.connector

  device_access_group = var.device_access_group != "" ? var.device_access_group : null
  expiring            = var.expiring
  expires             = var.expires != "" ? var.expires : null
  retrieve_key        = var.retrieve_key
}
