resource "authentik_source_scim" "this" {
  name = var.name
  slug = var.slug

  enabled            = var.enabled
  user_path_template = var.user_path_template != "" ? var.user_path_template : null

  property_mappings       = length(var.property_mappings) > 0 ? var.property_mappings : null
  property_mappings_group = length(var.property_mappings_group) > 0 ? var.property_mappings_group : null
}
