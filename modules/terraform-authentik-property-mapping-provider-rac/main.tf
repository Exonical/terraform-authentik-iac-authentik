resource "authentik_property_mapping_provider_rac" "this" {
  name = var.name

  expression = var.expression != "" ? var.expression : null
  settings   = var.settings != "" ? var.settings : null
}
