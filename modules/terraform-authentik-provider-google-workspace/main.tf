resource "authentik_provider_google_workspace" "this" {
  name                       = var.name
  default_group_email_domain = var.default_group_email_domain

  credentials         = var.credentials != "" ? var.credentials : null
  delegated_subject   = var.delegated_subject != "" ? var.delegated_subject : null
  filter_group        = var.filter_group != "" ? var.filter_group : null
  user_delete_action  = var.user_delete_action != "" ? var.user_delete_action : null
  group_delete_action = var.group_delete_action != "" ? var.group_delete_action : null
  dry_run             = var.dry_run
  exclude_users_service_account = var.exclude_users_service_account

  property_mappings       = length(var.property_mappings) > 0 ? var.property_mappings : null
  property_mappings_group = length(var.property_mappings_group) > 0 ? var.property_mappings_group : null
}
