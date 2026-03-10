resource "authentik_provider_microsoft_entra" "this" {
  name          = var.name
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id

  filter_group        = var.filter_group != "" ? var.filter_group : null
  user_delete_action  = var.user_delete_action != "" ? var.user_delete_action : null
  group_delete_action = var.group_delete_action != "" ? var.group_delete_action : null
  dry_run             = var.dry_run
  exclude_users_service_account = var.exclude_users_service_account

  property_mappings       = length(var.property_mappings) > 0 ? var.property_mappings : null
  property_mappings_group = length(var.property_mappings_group) > 0 ? var.property_mappings_group : null
}
