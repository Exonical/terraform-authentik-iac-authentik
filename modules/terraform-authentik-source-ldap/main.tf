resource "authentik_source_ldap" "this" {
  name          = var.name
  slug          = var.slug
  server_uri    = var.server_uri
  bind_cn       = var.bind_cn
  bind_password = var.bind_password
  base_dn       = var.base_dn

  enabled                                = var.enabled
  start_tls                              = var.start_tls
  sni                                    = var.sni
  sync_users                             = var.sync_users
  sync_users_password                    = var.sync_users_password
  sync_groups                            = var.sync_groups
  delete_not_found_objects               = var.delete_not_found_objects
  lookup_groups_from_user                = var.lookup_groups_from_user
  password_login_update_internal_password = var.password_login_update_internal_password

  additional_user_dn          = var.additional_user_dn != "" ? var.additional_user_dn : null
  additional_group_dn         = var.additional_group_dn != "" ? var.additional_group_dn : null
  user_object_filter          = var.user_object_filter != "" ? var.user_object_filter : null
  group_object_filter         = var.group_object_filter != "" ? var.group_object_filter : null
  group_membership_field      = var.group_membership_field != "" ? var.group_membership_field : null
  user_membership_attribute   = var.user_membership_attribute != "" ? var.user_membership_attribute : null
  object_uniqueness_field     = var.object_uniqueness_field != "" ? var.object_uniqueness_field : null
  user_path_template          = var.user_path_template != "" ? var.user_path_template : null
  sync_parent_group           = var.sync_parent_group != "" ? var.sync_parent_group : null
  sync_outgoing_trigger_mode  = var.sync_outgoing_trigger_mode != "" ? var.sync_outgoing_trigger_mode : null

  property_mappings       = length(var.property_mappings) > 0 ? var.property_mappings : null
  property_mappings_group = length(var.property_mappings_group) > 0 ? var.property_mappings_group : null
}
