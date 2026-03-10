resource "authentik_provider_scim" "this" {
  name = var.name
  url  = var.url

  exclude_users_service_account = var.exclude_users_service_account
  token                         = var.token != "" ? var.token : null
  filter_group                  = var.filter_group != "" ? var.filter_group : null

  property_mappings       = length(var.property_mappings) > 0 ? var.property_mappings : null
  property_mappings_group = length(var.property_mappings_group) > 0 ? var.property_mappings_group : null
}
