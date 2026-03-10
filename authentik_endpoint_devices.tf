locals {
  ed_connector_agents    = try(local.endpoint_devices.connector_agents, [])
  ed_device_access_groups = try(local.endpoint_devices.device_access_groups, [])
  ed_rac_endpoints       = try(local.endpoint_devices.rac_endpoints, [])
  ed_enrollment_tokens   = try(local.endpoint_devices.enrollment_tokens, [])
}

module "authentik_endpoints_connector_agent" {
  source   = "./modules/terraform-authentik-endpoints-connector-agent"
  for_each = { for a in local.ed_connector_agents : a.name => a if local.modules.authentik_endpoints_connector_agent == true && var.manage_endpoint_devices }

  name = each.value.name

  enabled                          = try(each.value.enabled, true)
  authorization_flow               = try(local.flow_map[each.value.authorization_flow], "")
  auth_session_duration            = try(each.value.auth_session_duration, "")
  auth_terminate_session_on_expiry = try(each.value.auth_terminate_session_on_expiry, false)
  challenge_idle_timeout           = try(each.value.challenge_idle_timeout, "")
  challenge_key                    = try(each.value.challenge_key, "")
  challenge_trigger_check_in       = try(each.value.challenge_trigger_check_in, false)
  refresh_interval                 = try(each.value.refresh_interval, "")
  snapshot_expiry                  = try(each.value.snapshot_expiry, "")
  nss_uid_offset                   = try(each.value.nss_uid_offset, 0)
  nss_gid_offset                   = try(each.value.nss_gid_offset, 0)
  jwt_federation_providers         = try(each.value.jwt_federation_providers, [])
}

module "authentik_endpoints_device_access_group" {
  source   = "./modules/terraform-authentik-endpoints-device-access-group"
  for_each = { for g in local.ed_device_access_groups : g.name => g if local.modules.authentik_endpoints_device_access_group == true && var.manage_endpoint_devices }

  name = each.value.name
}

module "authentik_rac_endpoint" {
  source   = "./modules/terraform-authentik-rac-endpoint"
  for_each = { for e in local.ed_rac_endpoints : e.name => e if local.modules.authentik_rac_endpoint == true && var.manage_endpoint_devices }

  name              = each.value.name
  host              = each.value.host
  protocol          = each.value.protocol
  protocol_provider = try(local.provider_id_map[each.value.protocol_provider], each.value.protocol_provider)

  maximum_connections = try(each.value.maximum_connections, 1)
  property_mappings  = try(each.value.property_mappings, [])
  settings           = try(each.value.settings, "")
}

module "authentik_endpoints_connector_agent_enrollment_token" {
  source   = "./modules/terraform-authentik-endpoints-connector-agent-enrollment-token"
  for_each = { for t in local.ed_enrollment_tokens : t.name => t if local.modules.authentik_endpoints_connector_agent_enrollment_token == true && var.manage_endpoint_devices }

  name      = each.value.name
  connector = try(module.authentik_endpoints_connector_agent[each.value.connector].id, each.value.connector)

  device_access_group = try(module.authentik_endpoints_device_access_group[each.value.device_access_group].id, try(each.value.device_access_group, ""))
  expiring            = try(each.value.expiring, true)
  expires             = try(each.value.expires, "")
  retrieve_key        = try(each.value.retrieve_key, true)
}
